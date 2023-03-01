

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
Run this cell to initialize the environment, also make sure change the vriable "project_name". project_name looks like "CHI-XXXXX" and it is the name of your project which you were assigned. 

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

::: {.cell .markdown}

To ensure uniqueness, each server within a project must have a distinct name. To differentiate your servers from those of your peers, the server's name should be composed of your chameleon username and an exp_name that your instructor has specified in the cell provided below.

:::

::: {.cell .code}
```python
exp_name = ""
user = os.getenv("USER")
server_name = f"{exp_name}_{user}"
```
:::


::: {.cell .markdown}

### Creating the server

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
Associate an IP address with this server:

:::
::: {.cell .code}
```python
reserved_fip = chi.server.associate_floating_ip(server_id)
reserved_fip
```
:::

::: {.cell .markdown}

### Creating a Security group
A security group named "Allow SSH" will be generated in the following cell for our project, enabling us to connect to the remote server from our local desktop.
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

::: {.cell .markdown}

The preceding cell generated a security group, and this cell will attach that security group to our server, making it ready to be accessed via SSH.

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



