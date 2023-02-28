
::: {.cell .markdown}
## Exercise: transfer files to and from resources

To securely transfer files between a local and a remote host, we will use the command-line tool called Secure Copy (SCP), which uses the Secure Shell (SSH) protocol for encryption and authentication. SCP provides a secure method for transferring files over a network, ensuring that data remains protected during the transfer process.

SCP is many times confusing, so to simplify it we can follow these rules:

1. The path of the file or folder which is to be transfered should always come first.

2. The path to which it has to be transfered comes after.

3. Use -r when you are trying to transfer a directory of folder.

4. use -i "key_path" when your key is not at the default location.

5. When you are transfering a file from a remote host to your laptop, you will run *scp* from a terminal on your laptop.(Not on a terminal that is logged into the remote host)

:::

::: {.cell .markdown}

### Using jupyter environment to transfer files vias *scp*

When we logged in via jupyter environment we created a file named hello.txt that is on our remote host, here we will run a *scp* command to get that file from remote to our jupyter environment.
:::

::: {.cell .code}

```python
node.run("scp cc@{reserved_fip}:/home/cc/hello.txt .")

```

:::


Now we have hello.txt in our jupyter environment we will make some changes to it by directly opening and changing it in the jupyter environment and then transfer the same file to the remote host.

::: {.cell .code}

```python
node.run("scp ~/work/hello.txt cc@{reserved_fip}:/home/cc/")

```
:::

::: {.cell .markdown}

### Transfering files through the local terminal

When we logged in through our local environment on the terminal of our laptop, We created a folder "chameleon" and inside the folder we created a file "hello.txt" on the remote host. Here in this exercise we will run a *scp* command to get that file from remote host to our laptop.



```shell
user@username:~$ scp cc@reserved_fip:/home/cc/chameleon/hello.txt .
hello.txt                       100%    1KB     0.1KB/s   00:00
user@username:~$
```



Run the code below and you will get the exact command which you have to use in your local terminal

:::

::: {.cell .code}

```python
print(f'scp cc@{reserved_fip}:/home/cc/chameleon/hello.txt .')

```
:::

::: {.cell .markdown}

Now we have transfered hello.txt from remote host to our laptop. Now we can open that file edit it in any of the editor and then try transfering the same to remote host.

```shell
user@username:~$ scp hello.txt cc@reserved_fip:/home/cc/chameleon/
hello.txt                       100%    1KB     0.1KB/s   00:00
user@username:~$
```

Run the code below and you will get the exact command which you have to use in your local terminal to transfer the file back to remote host
:::

::: {.cell .code}

```python
print(f'scp hello.txt cc@{reserved_fip}:/home/cc/chameleon/')

```
:::


::: {.cell .markdown}

Use -i "key_path" if your Chameleon key is not in the default location.

Run the code below and you will get a similar command for transfering the file with key path when the file is not present at the default location.
:::


::: {.cell .code}
```python
print(f'scp -i "~/.ssh/id_rsa_chameleon" hello.txt cc@{reserved_fip}:/home/cc/chameleon/')

```
:::

