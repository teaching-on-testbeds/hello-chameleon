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

Run this cell to initialize the environment, also make sure change the vriable "project_name". project_name looks like "CHI-XXXXX" and it is the name of your project which you were assigned.

``` python
import chi,os
project_name = "CHI-XXXXXX"
os.environ["OS_PROJECT_NAME"] = project_name
chi.set("project_name", project_name)  
chi.use_site("KVM@TACC")
```

To ensure uniqueness, each server within a project must have a distinct name. To differentiate your servers from those of your peers, the server's name should be composed of your chameleon username and an exp_name that your instructor has specified in the cell provided below.

``` python
exp_name = ""
user = os.getenv("USER")
server_name = f"{exp_name}_{user}"
```

### Creating the server

``` python
import chi.server
flavor = "m1.small"
image_name = "CC-Ubuntu20.04"
server = chi.server.create_server(server_name, 
                                  image_name=image_name, 
                                  flavor_name=flavor)

server_id = server.id
chi.server.wait_for_active(server_id)
```

Associate an IP address with this server:

``` python
reserved_fip = chi.server.associate_floating_ip(server_id)
reserved_fip
```

### Creating a Security group

A security group named "Allow SSH" will be generated in the following cell for our project, enabling us to connect to the remote server from our local desktop.

``` python
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

The preceding cell generated a security group, and this cell will attach that security group to our server, making it ready to be accessed via SSH.

``` python
nova_server = chi.nova().servers.get(server_id)
nova_server.add_security_group("Allow SSH")
f"updated security groups: {[group.name for group in nova_server.list_security_group()]}"
```

Wait for the server to be ready to connect.

``` python
server.wait_for_tcp(reserved_fip, port=22)
```

Now our resources are reserved and ready to login through SSH

## Exercise: log in to resources and execute commands

### Logging in over SSH via local terminal

Once your server is ready to use. you can follow the guidelines below to log in to your server via SSH.

Run the cell below and use it's output as the exact command to login through your laptop's terminal.

``` python

print(f"ssh -i ~/.ssh/id_rsa_chameleon cc@{reserved_fip}")
```

The first time you log in to each new host, your computer will display a warning similar to the following:

``` shell
The authenticity of host "129.114.26.xx (129.114.26.xx)" cannot be established.
ED25519 key fingerprint is SHA256:1fcbGrgLDdOeorauhz3CTyhmFqOHsrEWlu0TZ6yGoDM.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```

and you will have to type the word *yes* and hit Enter to continue. If you have specified your key path and other details correctly, it won't ask you for a password when you log in to the node. (It may ask for the passphrase for your private key if you've set one.)

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

We will create a file hello.txt on our remote machine.

``` shell
:~$ echo "Hello from $(hostname)" > hello.txt
```

Now we will use this file "hello.txt" in the later exercises where we will see how transfering of file works between remote host and local host.

## Exercise: transfer files to and from resources

While working on a remote host we have to transfer files from remote to local and vice versa. To move data back and forth between your laptop and remote system that you access with *ssh*, we can use *scp*. The syntax is:

``` shell
scp [OPTIONS] SOURCE DESTINATION
```

where SOURCE is the full address of the location where the file is currently llocated, and DESTINATION is the address of the location that you want to copy a file to.

When you are transferring a file from a remote host to your laptop, you will run scp from a terminal on your laptop (NOT a terminal that is logged in to the remote host), and the syntax will look like this:

### Transfering files through the local terminal

When we logged in through our local environment on the terminal of our laptop, We created a folder "chameleon" and inside the folder we created a file "hello.txt" on the remote host. Here in this exercise we will run a *scp* command to get that file from remote host to our laptop.

``` shell
user@username:~$ scp -i ~/.ssh/id_rsa_chameleon cc@reserved_fip:/home/cc/chameleon/hello.txt .
hello.txt                       100%    1KB     0.1KB/s   00:00
user@username:~$
```

Run the code below and you will get the exact command which you have to use in your local terminal

``` python
print(f'scp -i ~/.ssh/id_rsa_chameleon cc@{reserved_fip}:/home/cc/chameleon/hello.txt .')
```

Now we have transfered hello.txt from remote host to our laptop. Now we can open that file edit it in any of the editor and then try transfering the same to remote host.

``` shell
user@username:~$ scp hello.txt cc@reserved_fip:/home/cc/chameleon/
hello.txt                       100%    1KB     0.1KB/s   00:00
user@username:~$
```

Run the code below and you will get the exact command which you have to use in your local terminal to transfer the file back to remote host

``` python
print(f'scp -i ~/.ssh/id_rsa_chameleon hello.txt cc@{reserved_fip}:/home/cc/chameleon/')
```

Use of `-i ~/.ssh/id_rsa_chameleon` is optional if your Chameleon key is in the default location.

## Exercise: delete resources

Once you are done using the resources, you can delete them by changing DELETE = True and run the cell below.

Once you delete your resources, you will no longer have access to them, and all the data on them will be deleted. Make sure that you have saved everything before you delete your resources.

``` python
DELETE = False

if DELETE:
    chi.server.delete_server(server_id)
    ip_details = chi.network.get_floating_ip(reserved_fip)
    chi.neutron().delete_floatingip(ip_details["id"])
```
<hr>

<small>Questions about this material? Contact Fraida Fund</small>

<hr>

<small>This material is based upon work supported by the National Science Foundation under Grant No. 2231984 and Grant No. 2230079.</small>
<small>Any opinions, findings, and conclusions or recommendations expressed in this material are those of the author(s) and do not necessarily reflect the views of the National Science Foundation.</small>


