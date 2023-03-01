
::: {.cell .markdown}
## Exercise: log in to resources and execute commands


:::


::: {.cell .markdown}
### Logging in over SSH via local terminal
Once your server is ready to use. you can follow the guidelines below to log in to your server via SSH.

:::

::: {.cell .markdown}
Run the cell below and use it's output as the exact command to login through your laptop's terminal.
:::

::: {.cell .code}
```python

print(f"ssh -i ~/.ssh/id_rsa_chameleon cc@{reserved_fip}")

```
:::

::: {.cell .markdown}

The first time you log in to each new host, your computer will display a warning similar to the following: 

```shell
The authenticity of host "129.114.26.xx (129.114.26.xx)" cannot be established.
ED25519 key fingerprint is SHA256:1fcbGrgLDdOeorauhz3CTyhmFqOHsrEWlu0TZ6yGoDM.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])?
```
and you will have to type the word _yes_ and hit Enter to continue. If you have specified your key path and other details correctly, it won’t ask you for a password when you log in to the node. (It may ask for the passphrase for your private key if you’ve set one.)
:::

::: {.cell .markdown}

The output of the above command will look somewhat like this.
```shell
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
:::

::: {.cell .markdown}
We will create a file hello.txt on our remote machine.

```shell
:~$ echo "Hello from $(hostname)" > hello.txt
```
Now we will use this file "hello.txt" in the later exercises where we will see how transfering of file works between remote host and local host.
::: 
