

::: {.cell .markdown}
### Exercise: reserve resources

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
project_name = input("Enter your project name")
chi.set("project_name", "CHI-231095")  # Please change this to your project name (CH-XXXXXX)
chi.use_site("KVM@TACC")
```
:::

::: {.cell .code}
```python
exp_name = input("Enter your experiment name here")
user = os.getenv("USER")
server_name = f"{user}_{exp_name}"
image_name = "CC-Ubuntu20.04"
```
:::

::: {.cell .markdown}
### Flavors
While Chameleon bare-metal is limited to a single "flavor" of baremetal, KVM offers virtualized hardware which provides us with the flexibility to choose from various configurations to meet our specific needs, while minimizing the impact on our allocation quota.

As of writing this, there are currently **7** flavors available:

| Name        | VCPUs | RAM    | Total Disk |
|-------------|-------|--------|------------|
| m1.tiny     | 1     | 512 MB | 1 GB       |
| m1.small    | 1     | 2 GB   | 20 GB      |
| m1.medium   | 2     | 4 GB   | 40 GB      |
| m1.large    | 4     | 8 GB   | 40 GB      |
| m1.xlarge   | 8     | 16 GB  | 40 GB      |
| m1.xxlarge  | 16    | 32 GB  | 40 GB      |
| m1.xxxlarge | 16    | 64 GB  | 40 GB      |

Also, The number of flavors assigned to a project depends on the specific project.

:::

::: {.cell .markdown}
### Selecting Flavors
After running the cell below you will get a dropdown which consist of all the flavors assigned to your project. you can select one of the flavor which you feel will be sufficient for your experiment.

:::

::: {.cell .code}
```python
import chi.server
import ipywidgets as widgets
flavor = 'm1.tiny'
print('Available flavors')
drop_down = widgets.Dropdown(options=[i.name for i in chi.server.list_flavors()],
                                disabled=False)

def dropdown_handler(change):
    global flavor
    flavor = change.new  
drop_down.observe(dropdown_handler, names='value')
display(drop_down)
)
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
floating_ip = chi.server.associate_floating_ip(server_id)
floating_ip
```
:::

::: {.cell .markdown}

### Security groups
The KVM cloud has a distinctive feature in the form of security groups, which are firewall rules that can be configured through OpenStack and the Horizon dashboard. They offer a hassle-free approach to configure the security of your VM. Although these groups also exist in the bare-metal cloud, they don't serve any purpose there.

By default, all external connections to your VM are blocked. Therefore, to enable remote connections, you will need to assign the "Allow SSH" security group to your VM, which can be found by viewing the list of available groups.

It's important to note that in almost all cases, the "Allow SSH" security group is the ONLY group that you need to assign to your VM.

:::

::: {.cell .code}
```python
nova_server = chi.nova().servers.get(server_id)
f"current security groups: {[group.name for group in nova_server.list_security_group()]}"
```
:::

::: {.cell .code}
```python
[group["name"] for group in chi.neutron().list_security_groups()["security_groups"] if "ssh" in group["name"].lower()]
```
:::

::: {.cell .code}
```python
nova_server.add_security_group("Allow SSH")
f"updated security groups: {[group.name for group in nova_server.list_security_group()]}"
```
:::

::: {.cell .markdown}

Now our resources are reserved and ready to login through SSH

:::



