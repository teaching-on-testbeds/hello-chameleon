

::: {.cell .markdown}
## Exercise: reserve resources

Whenever you run an experiment on Chameleon, you will

1. Open a Python notebook, which includes commands to reserve the resources (VMs, bare metal servers, or networks) that you need for your experiment. Run these commands.
2. Wait until the resources in your experiment are ready to log in.
3. Log in to the resources and run your experiment (either by executing commands in the notebook, or by using SSH in a terminal and running commands in those SSH sessions).

Also, when you finish an experiment and have saved all the data somewhere safe, you will _delete_ the resources in your experiment to free them for use by other experimenters.

In this exercise, we will reserve a resource on Chameleon.

:::
::: {.cell .markdown}

### Generating a Virtual Machine on chameleon
The below cells will take project_name and exp_name as input from the user to configure the experiment environment.

:::

::: {.cell .code}
```python
import chi,os
project_name = "CHI-XXXXXX"
os.environ["OS_PROJECT_NAME"] = project_name
chi.set("project_name", project_name)  
chi.use_site("KVM@TACC")
```
:::

::: {.cell .code}
```python
exp_name = ""
user = os.getenv("USER")
server_name = f"{exp_name}_{user}"

```
:::


::: {.cell .markdown}
### Assigning flavor and image_name


:::

::: {.cell .markdown}
Running this cell will show tha available images that could be used in our vm.
:::


::: {.cell .code}
```python
%%bash
openstack image list
```
:::

::: {.cell .markdown}
Select the image which you want to use and assign it to the image_name variable in the cell below. Here we have used CC-Ubuntu20.04 but you can use different according to your need.
:::

::: {.cell .code}
```python
flavor = "m1.small"
image_name = "CC-Ubuntu20.04"

```
:::

::: {.cell .markdown}

### Creating the server

:::

::: {.cell .code}
```python
import chi.server

server = chi.server.create_server(server_name, 
                                  image_name=image_name, 
                                  flavor_name=flavor)

server_id = server.id
chi.server.wait_for_active(server_id)
```
:::

::: {.cell .markdown}
### Attaching a floating IP

At KVM@TACC, since there are no reservations, we can easily obtain a floating IP address from the available pool without any prior booking. However, it's crucial to keep in mind that the pool of floating IPs is limited. Therefore, it's advisable to be mindful of your usage and not allocate more floating IPs than necessary, considering the other researchers who also need to utilize them.

In case you require multiple VMs for your experiment, a practical approach is to connect them all on one network. By doing so, you can use a single floating IP to link to a "head" node and access all the other nodes through it.

:::
::: {.cell .code}
```python
reserved_fip = chi.server.associate_floating_ip(server_id)
reserved_fip
```
:::

::: {.cell .markdown}

### Security groups
The KVM cloud has a distinctive feature in the form of security groups, which are firewall rules that can be configured through OpenStack and the Horizon dashboard. They offer a hassle-free approach to configure the security of your VM. Although these groups also exist in the bare-metal cloud, they don't serve any purpose there.

By default, all external connections to your VM are blocked. Therefore, to enable remote connections, you will need to assign the "Allow SSH" security group to your VM, which can be found by viewing the list of available groups.

It's important to note that in almost all cases, the "Allow SSH" security group is the ONLY group that you need to assign to your VM.

The cell below make sure that there is an Allow SSH security group created, if there is no such groups it creates one.

:::

::: {.cell .code}
```python
%%bash
export OS_AUTH_URL=https://kvm.tacc.chameleoncloud.org:5000/v3
export OS_REGION_NAME="KVM@TACC"

access_token=$(curl -s -H"authorization: token $JUPYTERHUB_API_TOKEN"     "$JUPYTERHUB_API_URL/users/$JUPYTERHUB_USER"     | jq -r .auth_state.access_token)
export OS_ACCESS_TOKEN="$access_token"
SECURITY_GROUP_NAME="Allow SSH"

if ! openstack security group show "$SECURITY_GROUP_NAME" > /dev/null 2>&1; then
    openstack security group create "$SECURITY_GROUP_NAME"  --description "Enable SSH traffic on TCP port 22"
    openstack security group rule create "$SECURITY_GROUP_NAME" \
     --protocol tcp --dst-port 22:22 --remote-ip 0.0.0.0/0


else
    echo "Security group already exists"
fi
```
:::

::: {.cell .code}
```python
nova_server = chi.nova().servers.get(server_id)
nova_server.add_security_group("Allow SSH")
f"updated security groups: {[group.name for group in nova_server.list_security_group()]}"
```
:::

Wait for the server to be ready to connect.


::: {.cell .code}
```python
server.wait_for_tcp(reserved_fip, port=22)
```
:::


::: {.cell .markdown}

Now our resources are reserved and ready to login through SSH

:::



