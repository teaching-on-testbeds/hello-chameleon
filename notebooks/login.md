
::: {.cell .markdown}
## Exercise: log in to resources and execute commands

In this exercise, we'll practice running commands on the VM resource by opening an SSH session in a local terminal and running commands in that session.

:::


::: {.cell .markdown}
### Log in over SSH from local terminal

To log in to the VM over SSH, you will:

* open your terminal application,
* run the cell below, which will print an SSH login command,
* copy this command and make any necessary modifications (if needed, as described in the following cell),
* paste it into your terminal and hit Enter.

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

If you have specified your key path and other details correctly, it won’t ask you for a password when you log in to the node. (It may ask for the passphrase for your private key if you’ve set one.)

:::

::: {.cell .markdown}

The output of the above command will look somewhat like this.
```shell
Welcome to Ubuntu 20.04.4 LTS (GNU/Linux 5.4.0-124-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

 System information disabled due to load higher than 1.0


0 updates can be applied immediately.


The list of available updates is more than a week old.
To check for new updates run: sudo apt update

Last login: Thu Mar  2 18:21:51 2023
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

cc@hello-chameleon-XXXXX-2023-3-02-18-18-49:~$ 
```
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
