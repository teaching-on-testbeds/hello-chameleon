
::: {.cell .markdown}

## Exercise: reserve resources

Whenever you run an experiment on Chameleon, you will

1. Open a Python notebook, which includes commands to reserve and configure the resources (VMs, bare metal servers, or networks) that you need for your experiment. Run these commands.
2. Wait until the resources in your experiment are ready to log in.
3. Log in to the resources and run your experiment (either by executing commands in the notebook, or by using SSH in a terminal and running commands in those SSH sessions).

Also, when you finish an experiment and have saved all the data somewhere safe, you will _delete_ the resources in your experiment to free them for use by other experimenters.

In this exercise, we will reserve a single virtual machine on Chameleon, and practice logging in to execute commands on this VM.

:::

::: {.cell .markdown}

First, we will need to initialize the environment - tell it what Chameleon project to associate our experiment with.

You should already be a part of a Chameleon project, which has a project ID in the form "CHI-XXXXX". If you don't know your project ID, you can find it by logging in to the Chameleon web portal, and checking your [dashboard](https://chameleoncloud.org/user/dashboard/). When you run the next cell, you will see a drop-down menu for selecting your project.

 We will also indicate which Chameleon site we want to use. Since this experiment uses a virtual machine, the site will be KVM@TACC - the only Chameleon site that supports VMs.

:::

::: {.cell .code}
```python
import chi, os, time, datetime
from chi import lease
from chi import server
from chi import context
from chi import hardware
from chi import network

context.version = "1.0" 
context.choose_project()
context.choose_site(default="KVM@TACC")
username = os.getenv('USER') # all exp resources will have this suffix
```
:::

::: {.cell .markdown}

Next, we'll give our resource a name. Every resource in a project should have a unique name, so we will include a username, as well as a description of the experiment, in the name.

:::

::: {.cell .code}
```python
exp_name = "hello_chameleon"
server_name = f"{exp_name}-{username}"
lease_name = f"{exp_name}-{username}"
```
:::


::: {.cell .markdown}

Now we are ready to ask Chameleon to allocate a resource to us! For a VM, we specify the "flavor" or size of the resource (in terms of CPU, memory, and storage) and the operating system image that we want to have pre-installed.

:::

::: {.cell .markdown}

First we will reserve the VM instance for 6 hours, starting now:

:::


::: {.cell .code}
```python
l = lease.Lease(lease_name, duration=datetime.timedelta(hours=6))
l.add_flavor_reservation(id=chi.server.get_flavor_id("m1.small"), amount=1)
l.submit(idempotent=True)
```
:::


::: {.cell .code}
```python
l.show()
```
:::


::: {.cell .markdown}

then we can launch it:

:::


::: {.cell .code}
```python
image_name = "CC-Ubuntu24.04"
s = server.Server(
    name=server_name,
    image_name=image_name,
    flavor_name=l.get_reserved_flavors()[0].name
)
s.submit(idempotent=True)
```
:::

::: {.cell .markdown}

Once the resource is allocated and ready, we will associate a network address to it, so that we can log in to the resource over the Internet using the SSH protocol.

:::

::: {.cell .code}
```python
s.associate_floating_ip()
```
:::

::: {.cell .code}
```python
reserved_fip = s.get_floating_ip()
print(reserved_fip)
```
:::

::: {.cell .markdown}


There's one more step before we can log in to the resource - by default, all connections to VM resources are blocked, as a security measure. We will need to add a "security group" that permits SSH connections to our project (if it does not already exist), then attach this security group to our VM resource.

:::

::: {.cell .code}
```python
sg_list = network.list_security_groups(name_filter="allow-ssh")
if sg_list: # allow-ssh already exists
    sg = sg_list[0]
else:       # create allow-ssh
    sg = network.SecurityGroup({"name": "allow-ssh", "description": "Enable SSH traffic on TCP port 22"})
    sg.add_rule("ingress", "tcp", 22)
    sg.submit()
s.add_security_group(sg.id)
```
:::


::: {.cell .markdown}


That's all we need to do to prepare a resource to log in! Run the following cell - when it returns, it means that the VM resource is ready for you to log in.

:::




::: {.cell .code}
```python
s.check_connectivity()
```
:::
