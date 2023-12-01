

::: {.cell .markdown}
## Exercise: reserve resources

Whenever you run an experiment on Chameleon, you will

1. Open a Python notebook, which includes commands to reserve and configure the resources (VMs, bare metal servers, or networks) that you need for your experiment. Run these commands.
2. Wait until the resources in your experiment are ready to log in.
3. Log in to the resources and run your experiment (either by executing commands in the notebook, or by using SSH in a terminal and running commands in those SSH sessions).

Also, when you finish an experiment and have saved all the data somewhere safe, you will _delete_ the resources in your experiment to free them for use by other experimenters.

In this exercise, we will reserve a single virutal machine on Chameleon, and practice logging in to execute commands on this VM.

:::
::: {.cell .markdown}

First, we will need to initialize the environment - tell it what Chameleon project to associate our experiment with. 

You should already be a part of a Chameleon project, which has a project ID in the form "CHI-XXXXX". If you don't know your project ID, you can find it by logging in to the Chameleon web portal, and checking your [dashboard](https://chameleoncloud.org/user/dashboard/).

Once you find out *your* project ID, replace the "CHI-XXXXXX" in this next cell with your project ID. Then, run the cell.
:::

::: {.cell .code}
```python
import openstack, chi, chi.ssh, chi.network, chi.server, os

project_id = "CHI-XXXXXX"
site_name = "KVM@TACC"
# tell python-chi what project to use, and where
chi.set("project_name", project_id)  
chi.use_site(site_name)

# configure openstacksdk for actions unsupported by python-chi
os_conn = chi.clients.connection()
```
:::

::: {.cell .markdown}

Next, we'll give our resource a name. Every resource in a project should have a unique name, so we will include your username and a timestamp, as well as a description of the experiment, in the name.

:::

::: {.cell .code}
```python
import datetime
exp_name = "hello_chameleon"
exp_user = os.getenv("USER")
exp_start = datetime.datetime.now().strftime("%Y%_m_%d_%H_%M_%S")
server_name = f"{exp_name}-{exp_user}-{exp_start}"
```
:::


::: {.cell .markdown}

Now we are ready to ask Chameleon to allocate a resource to us! For a VM, we specify the "flavor" or size of the resource (in terms of CPU, memory, and storage) and the operating system image that we want to have pre-installed.

:::

::: {.cell .code}
```python
import chi.server
flavor = "m1.small"
image_name = "CC-Ubuntu20.04"
server = chi.server.create_server(server_name, 
                                  image_name=image_name, 
                                  flavor_name=flavor)

server_id = server.id
chi.server.wait_for_active(server_id)
```
:::

::: {.cell .markdown}

Once the resource is allocated and ready, we will associate a network address to it, so that we can log in to the resource over the Internet using the SSH protocol.

:::
::: {.cell .code}
```python
reserved_fip = chi.server.associate_floating_ip(server_id)
reserved_fip
```
:::

::: {.cell .markdown}


There's one more step before we can log in to the resource - by default, all connections to VM resources are blocked, as a security measure. We will need to add a "security group" that permits SSH connections to our project (if it does not already exist), then attach this security group to our VM resource.

:::

::: {.cell .code}
```python
if not os_conn.get_security_group("Allow SSH"):
    os_conn.create_security_group("Allow SSH", "Enable SSH traffic on TCP port 22")
    os_conn.create_security_group_rule("Allow SSH", port_range_min=22, port_range_max=22, protocol='tcp', remote_ip_prefix='0.0.0.0/0')

nova_server = chi.nova().servers.get(server_id)
nova_server.add_security_group("Allow SSH")
f"updated security groups: {[group.name for group in nova_server.list_security_group()]}"
```
:::

::: {.cell .code}
```python
```
:::


::: {.cell .markdown}
By default, the SSH key in the Jupyter environment will be pre-installed on the server, but we also want to install any key(s) that we have uploaded to the KVM@TACC web interface. The following cell will install those keys:
:::


::: {.cell .code}
```python
# wait for server to be ready to log in
chi.server.wait_for_tcp(reserved_fip, port=22)
remote = chi.ssh.Remote(reserved_fip) 
nova=chi.clients.nova()
# iterate over all keypairs in this account
for kp in nova.keypairs.list(): 
    public_key = nova.keypairs.get(kp.name).public_key 
    remote.run(f"echo {public_key} >> ~/.ssh/authorized_keys") 
```
:::


::: {.cell .markdown}


That's all we need to do to prepare a resource to log in! Run the following cell - when it returns, it means that the VM resource is ready for you to log in.

:::




::: {.cell .code}
```python
chi.server.wait_for_tcp(reserved_fip, port=22)
```
:::
