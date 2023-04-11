
::: {.cell .markdown}
## Exercise: log in to resources and execute commands

## Exercise: log in to resources and execute commands

In this exercise, we'll practice running commands on the VM resource in three ways:

* by opening an SSH session in the terminal inside this Jupyter environment, and running commands in that session,
* by opening an SSH session in a local terminal and running commands in that session.
* by using the `python-chi` Python interface to execute commands from within this Python notebook.


:::



::: {.cell .markdown}
### Log in over SSH from Jupyter environment

One of the easiest ways to log in to your VM is to open a shell inside the Jupyter environment, and log in over SSH from that shell.

In the Chameleon JupyterHub environment, click File > New > Terminal. This will open another tab in the Jupyter environment, with a shell session.


:::

::: {.cell .markdown}

Now, run this cell to get the SSH login command. Copy the output of the cell:

:::


::: {.cell .code}
```python
print(f"ssh cc@{reserved_fip}")
```
:::

::: {.cell .markdown}

then switch to your terminal shell tab, paste the SSH login command, and hit Enter.

:::


::: {.cell .markdown}
The first time you log in to each new host, you may see a warning similar to the following: 

```shell
The authenticity of host "129.114.26.xx (129.114.26.xx)" cannot be established.
ED25519 key fingerprint is SHA256:1fcbGrgLDdOeorauhz3CTyhmFqOHsrEWlu0TZ6yGoDM.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```
and you will have to type the word _yes_ and hit Enter to continue. 

:::


::: {.cell .markdown}

Then, you'll be logged in! To validate that you are logged in to the remote host, and not running commands directly in the Jupyter shell environment, run

```shell
hostname
```

and verify that the output starts with "hello-chameleon".  (This is the hostname we assigned to our VM resource!)
:::

::: {.cell .markdown}
### Log in over SSH from local terminal

To log in to the VM over SSH from your local terminal, you will follow a similar process:

* open the terminal application *installed on your computer*,
* run the cell below, which will print an SSH login command,
* copy this command and make any necessary modifications (if needed, as described in the following cell),
* paste it into your terminal and hit Enter.

In this case, you will specify the key location as part of the SSH command. These instructions assume that, as described in the previous steps, you have created a key pair named `id_rsa_chameleon`, put it in the default `.ssh` subdirectory in your home directory, and uploaded it to the KVM@TACC web interface.

:::

::: {.cell .code}
```python
print(f"ssh -i ~/.ssh/id_rsa_chameleon cc@{reserved_fip}")
```
:::

::: {.cell .markdown}

If your Chameleon key is in a different location, or has a different name, then you may need to modify the `~/.ssh/id_rsa_chameleon` part of this command to point to *your* key.

:::

::: {.cell .markdown}

The first time you log in to each new host, your computer may display a warning similar to the following: 

```shell
The authenticity of host "129.114.26.xx (129.114.26.xx)" cannot be established.
ED25519 key fingerprint is SHA256:1fcbGrgLDdOeorauhz3CTyhmFqOHsrEWlu0TZ6yGoDM.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```
and you will have to type the word _yes_ and hit Enter to continue. 

If you have specified your key path and other details correctly, it won’t ask you for a password when you log in to the resource. (It may ask for the passphrase for your private key if you’ve set one.)

:::


::: {.cell .markdown}
Let's practice running a command in this remote session. Copy and paste the following command into the SSH terminal, to create a file and populate it with a "hello" message:


```shell
echo "Hello from $(hostname)" > hello.txt
```

then check the file contents:

```shell
cat hello.txt
```

Now we will use this file "hello.txt" in a later exercise, when we want to practice transferring files between the remote host and our own laptop!

::: 


::: {.cell .markdown}
### Using `python-chi` to execute commands on the remote host

:::


::: {.cell .markdown}
Finally, it's useful to know that we can also execute commands over SSH on the remote instance, directly from a Python notebook! The following cell shows an example, where we run the `hostname` command using the `python-chi` library:
:::

::: {.cell .code}
```python
import chi.ssh
remote = chi.ssh.Remote(reserved_fip) 
remote.run(f"hostname") 
```
:::
