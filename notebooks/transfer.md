
::: {.cell .markdown}
## Exercise: transfer files to and from resources

While working on a remote host we have to transfer files from remote to local and vice versa.
To move data back and forth between your laptop and remote system that you access with _ssh_, we can use _scp_. The syntax is:

```shell
scp [OPTIONS] SOURCE DESTINATION
```
where SOURCE is the full address of the location where the file is currently llocated, and DESTINATION is the address of the location that you want to copy a file to.

When you are transferring a file from a remote host to your laptop, you will run scp from a terminal on your laptop (NOT a terminal that is logged in to the remote host).

:::

::: {.cell .markdown}

### Transfering files through the local terminal

Upon accessing the remote host via our local environment's terminal, we generated a file named "hello.txt". In this exercise, we will execute an "scp" command to transfer the file from the remote host to our laptop.



```shell
user@username:~$ scp -i ~/.ssh/id_rsa_chameleon cc@reserved_fip:/home/cc/hello.txt .
hello.txt                       100%    1KB     0.1KB/s   00:00
user@username:~$
```



Run the code below and you will get the exact command which you have to use in your local terminal.

:::

::: {.cell .code}

```python
print(f'scp -i ~/.ssh/id_rsa_chameleon cc@{reserved_fip}:/home/cc/hello.txt .')

```
:::

::: {.cell .markdown}

We have successfully transferred "hello.txt" from the remote host to our laptop. We can now open the file in any text editor, make changes as necessary, and then attempt to transfer the updated file back to the remote host.

```shell
user@username:~$ scp hello.txt cc@reserved_fip:/home/cc/chameleon/
hello.txt                       100%    1KB     0.1KB/s   00:00
user@username:~$
```

Run the code below and you will get the exact command which you have to use in your local terminal to transfer the file back to remote host.
:::

::: {.cell .code}

```python
print(f'scp -i ~/.ssh/id_rsa_chameleon hello.txt cc@{reserved_fip}:/home/cc/')

```
:::


::: {.cell .markdown}

Use of `-i ~/.ssh/id_rsa_chameleon` is optional if your Chameleon key is in the default location.

:::



