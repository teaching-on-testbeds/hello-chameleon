
::: {.cell .markdown}
## Exercise: log in to resources and execute commands


:::

::: {.cell .markdown}
### Extracting the floating ip that is attached to our server


:::

::: {.cell .code}
```python
floating_ips = chi.network.list_floating_ips()
for ip in floating_ips:
    if ip['fixed_ip_address'] is not None:
        reserved_fip = ip['floating_ip_address']
        break
reserved_fip
```
:::

::: {.cell .markdown}
### Logging in over SSH via the jupyter env


:::

::: {.cell .code}
```python
from chi.ssh import Remote

node = Remote(reserved_fip)
node.is_connected
```
:::

::: {.cell .markdown}
**Executing terminal commands via notebook**


:::


::: {.cell .code}
```python
node.run('echo "Update starting"')
node.run('sudo apt update')
```
:::



::: {.cell .markdown}
### Logging in over SSH via local terminal
In a local terminal on your own laptop, run

:::

::: {.cell .markdown}
```shell
user@username:~$ ssh -L 127.0.0.1:8888:127.0.0.1:8888 cc@reserved_fip
```
If your Chameleon key is not in the default location, you should also specify the path to your key as an argument, using -i.

eg: ssh -L 127.0.0.1:8888:127.0.0.1:8888 cc@129.114.xx.xxx -i "<path_name>"
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
Now we have been logged in to our remote host.
we will run some commands to check the content of current directory

```shell
cc@cp3793-nyu-edu-fount:~$ ls
cc@cp3793-nyu-edu-fount:~$ 
```

We can see that the root directory is empty.

We will create a directory named chameleon and then create a file hello.txt inside it.

```shell
cc@cp3793-nyu-edu-fount:~$ mkdir chameleon
cc@cp3793-nyu-edu-fount:~$ cd chameleon
cc@cp3793-nyu-edu-fount:~/chameleon$ 
cc@cp3793-nyu-edu-fount:~/chameleon$ cat > hello.txt
hello , welcome to chameleon
c@cp3793-nyu-edu-fount:~/chameleon$ 
```
We will use the file and directory created in the later exercises where we will see how transfering of file works between remote host and local host.
::: 
