# Hello, Chameleon

In this tutorial, you will learn how to use Chameleon to run experiments in computer networks or cloud computing. It should take you about 60-90 minutes of *active* time to work through this tutorial.

> **Note** This process has a "human in the loop" approval stage - you'll need to wait for your instructor or research advisor to approve your request to join their project. Be prepared to start the tutorial, wait for this approval, and then continue.

Chameleon is a "virtual lab" for experiments on networking, cloud computing, and distributed systems. It allows experimenters to set up real (not simulated!) bare metal servers at Chameleon host sites located around the United States. Experimenters can then log in to the hosts associated with their experiment and install software, run applications, and collect measurements.

Before you can run lab experiments on Chameleon, you will need to set up an account. Once you have completed the steps on this page, you will have an account that you can use for future experiments.

## Prepare your workstation

You'll need to prepare your workstation (the laptop or PC you are going to use for your experiments) with a suitable terminal application.

### Terminal software

To use Chameleon, the primary software application you'll need is a terminal, which you will use to log in to remote hosts over SSH.

You may have a terminal application already on your workstation. If not, here are some suggestions:

-   [cmder](https://cmder.app/) for Windows. (Get the full version, not the mini version.)
-   [iTerm2](https://www.iterm2.com/) for Mac
-   [terminator](https://launchpad.net/terminator) for Linux

Once you have downloaded and installed your terminal application, make sure you know how to open it!

## Set up your account on Chameleon

Now that you have the software you need, you are ready to set up an account on Chameleon.

### Exercise: Create an account

> **Note** To complete this step, you'll need to know the **Project Name** of the project that you will join. Your instructor or research advisor will tell you the project name to use.

First, go to <https://chameleoncloud.org/> and click on "Log In".

Click on the link that says "Sign up now"

![Sign up for a Chameleon account.](images/sign-up.png)

to get to the user registration page. Then, click "Sign in via federated login".

You will want your Chameleon account to be linked to your university credentials, so select your university from the list:

![Select your university from this list.](images/sign-up-federated.png)

and then click Continue. Log in with your university credentials.

Click Continue at the next prompt:

![Continue without linking another account.](images/continue-no-link.png)

Confirm that you will use Chameleon for non-profit research or educational purposes, and agree to the Globus terms:

![Confirm non-profit use.](images/agree-terms.png)

Allow Chameleon to get your name and email address from your university login:

![Share identity with Chameleon.](images/allow-view.png)

Then, read and accept the Chameleon terms of use and acceptable use policy. Also click OK to agree to acknowledge Chameleon in any publication supported by its use.

### Exercise: Join a project

At this stage, you have an account on Chameleon, but your account is not yet a part of any project. To use Chameleon, you need to be a part of a project that has been approved by the Chameleon staff, under the supervision of a project lead who supervises your use of Chameleon.

If you click on the "Projects" tab in the Chameleon dashboard, you'll see this:

![Before joining a project.](images/no-project.png)

Tell your instructor that you have created your Chameleon account, and let them know the email address associated with your Chameleon account. Once they have added you to their project, you'll see it listed on that page, and you can continue with the next step.

### Exercise: Create SSH keys

Once you are part of a project with an active allocation, you can set up SSH keys.

> Note: If you already have an SSH key pair, you can use it with Chameleon - copy the contents of the public key, then skip to the "Exercise: Upload SSH keys to Chameleon" section and continue there. If you don't already have an SSH key pair, continue with the rest of this section.

Chameleon users access resources using *public key authentication*. Using SSH public-key authentication to connect to a remote system is a more secure alternative to logging in with an account password.

SSH public-key authentication uses a pair of separate keys (i.e., a key pair): one "private" key, which you keep a secret, and the other "public". A key pair has a special property: any message that is encrypted with your private key can only be decrypted with your public key, and any message that is encrypted with your public key can only be decrypted with your private key.

This property can be exploited for authenticating login to a remote machine. First, you upload the public key to a special location on the remote machine. Then, when you want to log in to the machine:

1.  You use a special argument with your SSH command to let your SSH application know that you are going to use a key, and the location of your private key. If the private key is protected by a passphrase, you may be prompted to enter the passphrase (this is not a password for the remote machine, though).
2.  The machine you are logging in to will ask your SSH client to "prove" that it owns the (secret) private key that matches an authorized public key. To do this, the machine will send a random message to you.
3.  Your SSH client will encrypt the random message with the private key and send it back to the remote machine.
4.  The remote machine will decrypt the message with your public key. If the decrypted message matches the message it sent you, it has "proof" that you are in possession of the private key for that key pair, and will grant you access (without using an account password on the remote machine.)

(Of course, this relies on you keeping your private key a secret.)

We're going to generate a key pair on our laptop, then upload it to the Chameleon sites we are likely to use.

Open a terminal, and generate a key named `id_rsa_chameleon`:

    ssh-keygen -t rsa -f ~/.ssh/id_rsa_chameleon

Follow the prompts to generate and save the key pair. The output should look something like this:

    $ ssh-keygen -t rsa
    Generating public/private rsa key pair.
    Enter file in which to save the key (/users/ffund01/.ssh/id_rsa_chameleon): 
    Enter passphrase (empty for no passphrase): 
    Enter same passphrase again: 
    Your identification has been saved in /users/ffund01/.ssh/id_rsa_chameleon.
    Your public key has been saved in /users/ffund01/.ssh/id_rsa_chameleon.pub.
    The key fingerprint is:
    SHA256:z1W/psy05g1kyOTL37HzYimECvOtzYdtZcK+8jEGirA ffund01@example.com
    The key's randomart image is:
    +---[RSA 2048]----+
    |                 |
    |                 |
    |           .  .  |
    |          + .. . |
    |    .   S .*.o  .|
    |     oo. +ooB o .|
    |    E .+.ooB+* = |
    |        oo+.@+@.o|
    |        ..o==@ =+|
    +----[SHA256]-----+

If you use a passphrase, make a note of it somewhere safe! (You don't have to use a passphrase, though - feel free to leave that empty for no passphrase.)

Then, run

    cat ~/.ssh/id_rsa_chameleon.pub

to print the contents of the public key to your terminal. You will need this in the next step.

### Exercise: Upload SSH keys to Chameleon

Now, we will upload this key to several of the Chameleon sites we are most likely to use: KVM@TACC, CHI@TACC, and CHI@UC. (If you later run an experiment at a Chameleon site not on this list, you'll need to upload this key there, too.)

While logged on to the Chameleon user portal, click on Experiment \> KVM@TACC.

Click on the "Key Pairs" option in the Compute menu:

![Open the key pair setup page.](images/generate-keypairs.png)

Then click on "Import Public Key".

Name your key, set the key type to "SSH key", and then paste the contents of your public key:

![Import public key.](images/upload-pubkey.png)

Then, click "Import Public Key" to save the key to your profile.

While logged on to the Chameleon user portal, click on Experiment \> CHI@TACC and repeat this step there.

Then, click on Experiment \> CHI@UC and repeat this step there, too.

### Exercise: Open this notebook in Jupyter

Once you are part of a Chameleon project, you can reserve resources on Chameleon and access them over SSH! We'll use Chameleon's Jupyter environment for this.

From the [Chameleon website](https://chameleoncloud.org/), click on "Experiment \> Jupyter Interface" in the menu. You may be prompted to log in again.

To continue working on this tutorial, you'll want to get the rest in "notebook" form.

In the Jupyter environment, select File \> New \> Terminal and in this terminal, run

    git clone https://github.com/teaching-on-testbeds/hello-chameleon

Then, in the file browser on the left side, open the `hello-chameleon` directory and then double-click on the `hello_chameleon.ipynb` notebook to open it.

If you are prompted about a choice of kernel, you can accept the Python3 kernel.

Then, you can continue this tutorial by executing the cells in the notebook directly in this Jupyter environment.

## Exercise: reserve resources

Whenever you run an experiment on Chameleon, you will

1.  Open a Python notebook, which includes commands to reserve the resources (VMs, bare metal servers, or networks) that you need for your experiment. Run these commands.
2.  Wait until the resources in your experiment are ready to log in.
3.  Log in to the resources and run your experiment (either by executing commands in the notebook, or by using SSH in a terminal and running commands in those SSH sessions).

Also, when you finish an experiment and have saved all the data somewhere safe, you will *delete* the resources in your experiment to free them for use by other experimenters.

In this exercise, we will reserve a resource on Chameleon.

### Generating a Virtual Machine on chameleon

The below cells will take project_name and exp_name as input from the user to configure the experiment environment.

``` python
import chi,os
project_name = input("Enter your project name")
chi.set("project_name", "CHI-231095")  # Please change this to your project name (CH-XXXXXX)
chi.use_site("KVM@TACC")
```

``` python
exp_name = input("Enter your experiment name here")
user = os.getenv("USER")
server_name = f"{user}_{exp_name}"
image_name = "CC-Ubuntu20.04"
```

### Flavors

While Chameleon bare-metal is limited to a single "flavor" of baremetal, KVM offers virtualized hardware which provides us with the flexibility to choose from various configurations to meet our specific needs, while minimizing the impact on our allocation quota.

As of writing this, there are currently **7** flavors available:

  Name          VCPUs   RAM      Total Disk
  ------------- ------- -------- ------------
  m1.tiny       1       512 MB   1 GB
  m1.small      1       2 GB     20 GB
  m1.medium     2       4 GB     40 GB
  m1.large      4       8 GB     40 GB
  m1.xlarge     8       16 GB    40 GB
  m1.xxlarge    16      32 GB    40 GB
  m1.xxxlarge   16      64 GB    40 GB

Also, The number of flavors assigned to a project depends on the specific project.

### Selecting Flavors

After running the cell below you will get a dropdown which consist of all the flavors assigned to your project. you can select one of the flavor which you feel will be sufficient for your experiment.

``` python
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
```

### Creating the server

``` python
import chi.server

server = chi.server.create_server(server_name, 
                                  image_name=image_name, 
                                  flavor_name=flavor)

server_id = server.id
chi.server.wait_for_active(server_id)
```

### Attaching a floating IP

At KVM@TACC, since there are no reservations, we can easily obtain a floating IP address from the available pool without any prior booking. However, it's crucial to keep in mind that the pool of floating IPs is limited. Therefore, it's advisable to be mindful of your usage and not allocate more floating IPs than necessary, considering the other researchers who also need to utilize them.

In case you require multiple VMs for your experiment, a practical approach is to connect them all on one network. By doing so, you can use a single floating IP to link to a "head" node and access all the other nodes through it.

``` python
floating_ip = chi.server.associate_floating_ip(server_id)
floating_ip
```

### Security groups

The KVM cloud has a distinctive feature in the form of security groups, which are firewall rules that can be configured through OpenStack and the Horizon dashboard. They offer a hassle-free approach to configure the security of your VM. Although these groups also exist in the bare-metal cloud, they don't serve any purpose there.

By default, all external connections to your VM are blocked. Therefore, to enable remote connections, you will need to assign the "Allow SSH" security group to your VM, which can be found by viewing the list of available groups.

It's important to note that in almost all cases, the "Allow SSH" security group is the ONLY group that you need to assign to your VM.

The cell below make sure that there is an Allow SSH security group created, if there is no such groups it creates one.

``` python
%%bash
export OS_AUTH_URL=https://kvm.tacc.chameleoncloud.org:5000/v3
export OS_REGION_NAME="KVM@TACC"
export OS_PROJECT_NAME="CHI-231095"

access_token=$(curl -s -H"authorization: token $JUPYTERHUB_API_TOKEN"     "$JUPYTERHUB_API_URL/users/$JUPYTERHUB_USER"     | jq -r .auth_state.access_token)
export OS_ACCESS_TOKEN="$access_token"
SECURITY_GROUP_NAME="Allow SSH"

if ! openstack security group show $SECURITY_GROUP_NAME > /dev/null 2>&1; then
    openstack security group create $SECURITY_GROUP_NAME  --description "Enable SSH traffic on TCP port 22"
    openstack security group rule create $SECURITY_GROUP_NAME \
     --protocol tcp --dst-port 22:22 --remote-ip 0.0.0.0/0


else
    echo "Security group already exists"
fi
```

``` python
nova_server = chi.nova().servers.get(server_id)
f"current security groups: {[group.name for group in nova_server.list_security_group()]}"
```

``` python
[group["name"] for group in chi.neutron().list_security_groups()["security_groups"] if "ssh" in group["name"].lower()]
```

``` python
nova_server.add_security_group("Allow SSH")
f"updated security groups: {[group.name for group in nova_server.list_security_group()]}"
```

Now our resources are reserved and ready to login through SSH

## Exercise: log in to resources and execute commands

### Extracting the floating ip that is attached to our server

``` python
floating_ips = chi.network.list_floating_ips()
for ip in floating_ips:
    if ip['fixed_ip_address'] is not None:
        reserved_fip = ip['floating_ip_address']
        break
reserved_fip
```

### Logging in over SSH via the jupyter env

``` python
from chi.ssh import Remote

node = Remote(reserved_fip)
node.is_connected
```

**Executing terminal commands via notebook**

``` python
node.run('echo "Update starting"')
node.run('sudo apt update')
```

### Logging in over SSH via local terminal

In a local terminal on your own laptop, run

``` shell
user@username:~$ ssh -L 127.0.0.1:8888:127.0.0.1:8888 cc@reserved_fip
```

If your Chameleon key is not in the default location, you should also specify the path to your key as an argument, using -i.

eg: ssh -L 127.0.0.1:8888:127.0.0.1:8888 cc@129.114.xx.xxx -i "`<path_name>`{=html}"

The output of the above command will look somewhat like this.

``` shell
Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.4.0-124-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Thu Feb 23 17:52:13 UTC 2023

  System load:  0.08               Processes:             143
  Usage of /:   10.5% of 36.90GB   Users logged in:       1
  Memory usage: 12%                IPv4 address for ens3: 10.56.0.154
  Swap usage:   0%


0 updates can be applied immediately.


Last login: Thu Feb 23 16:44:05 2023 from 100.35.242.215
cc@cp3793-nyu-edu-fount:~$
```

Now we have been logged in to our remote host. we will run some commands to check the content of current directory

``` shell
cc@cp3793-nyu-edu-fount:~$ ls
cc@cp3793-nyu-edu-fount:~$ 
```

We can see that the root directory is empty.

We will create a directory named chameleon and then create a file hello.txt inside it.

``` shell
cc@cp3793-nyu-edu-fount:~$ mkdir chameleon
cc@cp3793-nyu-edu-fount:~$ cd chameleon
cc@cp3793-nyu-edu-fount:~/chameleon$ 
cc@cp3793-nyu-edu-fount:~/chameleon$ cat > hello.txt
hello , welcome to chameleon
c@cp3793-nyu-edu-fount:~/chameleon$ 
```

We will use the file and directory created in the later exercises where we will see how transfering of file works between remote host and local host.

## Exercise: transfer files to and from resources

To securely transfer files between a local and a remote host, we will use the command-line tool called Secure Copy (SCP), which uses the Secure Shell (SSH) protocol for encryption and authentication. SCP provides a secure method for transferring files over a network, ensuring that data remains protected during the transfer process.

SCP is many times confusing, so to simplify it we can follow these rules:

1.  The path of the file or folder which is to be transfered should always come first.

2.  The path to which it has to be transfered comes after.

3.  Use -r when you are trying to transfer a directory of folder.

4.  use -i "key_path" when your key is not at the default location.

Transfering the chameleon directory to local host from remote host

``` shell
user@username:~$ scp -r cc@reserved_fip:/home/cc/chameleon/ "local_path"
```

Now we have chameleon directory in our local, we will try to access hello.txt file and modify it.

``` shell
user@username:~/chameleon$ nano hello.txt
hello , welcome to chameleon









                                                                           [ Read 1 line ]
^G Get Help     ^O Write Out    ^W Where Is     ^K Cut Text     ^J Justify      ^C Cur Pos      M-U Undo        M-A Mark Text   M-] To Bracket  M-Q Previous
^X Exit         ^R Read File    ^\ Replace      ^U Paste Text   ^T To Spell     ^_ Go To Line   M-E Redo        M-6 Copy Text   ^Q Where Was    M-W Next
```

We modified the content of the file. we can see if the same is visible or not throught the "cat" command.

``` shell
user@username:~/chameleon$ nano hello.txt
hello , welcome to chameleon. how are you doing ?
user@username:~$
```

Let's create a new python file inside our local chameleon folder.

``` shell
cc@cp3793-nyu-edu-fount:~/chameleon$ cat > chi_info.py
import chi
#chi is Chameleon Cloud Python client library, which is a Python package used for interacting with the Chameleon Cloud API.
print(help(chi))
c@cp3793-nyu-edu-fount:~/chameleon$ 
```

In the next steps, first we will see how to transfer chi_info.py file to remote host and then we can try transfering the complete folder to remote.

``` shell
user@username:~$ scp ./chameleon/chi_info.py  cc@reserved_fip:/home/cc/chameleon/
chi_info.py                        100%    2KB     0.1KB/s   00:00
user@username:~$
```

Now, open a new terminal log in through SSH and see if the same file is there or not.

``` shell
user@username:~$ ssh -L 127.0.0.1:8888:127.0.0.1:8888 cc@reserved_fip
cc@cp3793-nyu-edu-fount:~$cd chameleon
cc@cp3793-nyu-edu-fount:~/chameleon$ ls
hello.txt chi_info.py
```

We can see that chi_info.py has been transfered from our local host to remote host.

Next step will be first deleting a file and then deleting a directory.

To delete a file we use "rm filename" command

``` shell
cc@cp3793-nyu-edu-fount:~/chameleon$ rm chi_info.py
cc@cp3793-nyu-edu-fount:~/chameleon$ ls
cc@cp3793-nyu-edu-fount:~/chameleon$ ls
hello.txt
```

Next we will try deleting the complete directory.

To delete a directory we use "rm -r directory" command.

``` shell
cc@cp3793-nyu-edu-fount:~/chameleon$ cd ..
cc@cp3793-nyu-edu-fount:~/$ rm -r chameleon
cc@cp3793-nyu-edu-fount:~/$ ls
cc@cp3793-nyu-edu-fount:~/$
```

Now we don't have our chameleon directory.

But we have the same directory in our local. So, next we will try to transfer the directory from our local to remote host.

Open the local terminal in another tab.

and let's use the SCP command to recursively transfer the entire chameleon directory to our remote host.

``` shell
user@username:~$ scp -r user/chameleon cc@reserved_fip:/home/cc/
hello.txt                        100%   2.4KB/s   00:00
chi_info.py                      100%   3KB/s   00:00
user@username:~$
```

Let's check if directory is transfered or not.

Open the other terminal where we previously logged in to remote via ssh

``` shell
cc@cp3793-nyu-edu-fount:~/$ ls
chameleon
cc@cp3793-nyu-edu-fount:~/$ cd chameleon
cc@cp3793-nyu-edu-fount:~/chameleon$ ls
hello.txt chi-info.py
cc@cp3793-nyu-edu-fount:~/chameleon$
```

From the output above we can see that the entire directory was transfered successfully.

Run the cells below and you will find the exact scp commands which you can use to perform transfer operation. just provide the path of the file in remote host and entire path of the local host.

**Transfering a file to local host from remote host**

``` python

print(f'scp cc@{reserved_fip}:file_path "local_path"')
```

**Transfering a folder to remote host from local**

``` python

print(f'scp -r cc@{reserved_fip}:folder_path "local_path"')
```

**Transfering a file to local from remote host**

``` python
print(f'scp "local_path" cc@{reserved_fip}:file_path ')
```

**Transfering a folder to local from remote host**

``` python
print(f'scp -r "local_path" cc@{reserved_fip}:folder_path ')
```

Use -i "key_path" if your Chameleon key is not in the default location

## Exercise: delete resources

Once you are done using the resources, you can delete them by running the cell below. provide the input as "y" if you want to delete the resource.

``` python
DELETE = input("Are you sure you want to delete? y/n")

if DELETE == "y":
    chi.server.delete_server(server_id)
    ip_details = chi.network.get_floating_ip(reserved_fip)
    chi.neutron().delete_floatingip(ip_details["id"])
```
<hr>

<small>Questions about this material? Contact Fraida Fund</small>

<hr>

<small>This material is based upon work supported by the National Science Foundation under Grant No. 2231984 and Grant No. 2230079.</small>
<small>Any opinions, findings, and conclusions or recommendations expressed in this material are those of the author(s) and do not necessarily reflect the views of the National Science Foundation.</small>


