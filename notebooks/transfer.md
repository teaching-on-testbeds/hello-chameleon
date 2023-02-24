
::: {.cell .markdown}
## Exercise: transfer files to and from resources

To securely transfer files between a local and a remote host, we will use the command-line tool called Secure Copy (SCP), which uses the Secure Shell (SSH) protocol for encryption and authentication. SCP provides a secure method for transferring files over a network, ensuring that data remains protected during the transfer process.

SCP is many times confusing, so to simplify it we can follow these rules:

1. The path of the file or folder which is to be transfered should always come first.

2. The path to which it has to be transfered comes after.

3. Use -r when you are trying to transfer a directory of folder.

4. use -i "key_path" when your key is not at the default location.

:::

::: {.cell .markdown}

Transfering the chameleon directory to local host from remote host

```shell
user@username:~$ scp -r cc@reserved_fip:/home/cc/chameleon/ "local_path"

```

Now we have chameleon directory in our local, we will try to access hello.txt file and modify it.

```shell
user@username:~/chameleon$ nano hello.txt
hello , welcome to chameleon









                                                                           [ Read 1 line ]
^G Get Help     ^O Write Out    ^W Where Is     ^K Cut Text     ^J Justify      ^C Cur Pos      M-U Undo        M-A Mark Text   M-] To Bracket  M-Q Previous
^X Exit         ^R Read File    ^\ Replace      ^U Paste Text   ^T To Spell     ^_ Go To Line   M-E Redo        M-6 Copy Text   ^Q Where Was    M-W Next

```
We modified the content of the file. we can see if the same is visible or not throught the "cat" command.

```shell
user@username:~/chameleon$ nano hello.txt
hello , welcome to chameleon. how are you doing ?
user@username:~$
```
Let's create a new python file inside our local chameleon folder.

```shell
cc@cp3793-nyu-edu-fount:~/chameleon$ cat > chi_info.py
import chi
#chi is Chameleon Cloud Python client library, which is a Python package used for interacting with the Chameleon Cloud API.
print(help(chi))
c@cp3793-nyu-edu-fount:~/chameleon$ 
```

In the next steps, first we will see how to transfer chi_info.py file to remote host and then we can try transfering the complete folder to remote.

```shell
user@username:~$ scp ./chameleon/chi_info.py  cc@reserved_fip:/home/cc/chameleon/
chi_info.py                        100%    2KB     0.1KB/s   00:00
user@username:~$

```
Now, open a new terminal log in through SSH and see if the same file is there or not.

```shell
user@username:~$ ssh -L 127.0.0.1:8888:127.0.0.1:8888 cc@reserved_fip
cc@cp3793-nyu-edu-fount:~$cd chameleon
cc@cp3793-nyu-edu-fount:~/chameleon$ ls
hello.txt chi_info.py
```
We can see that chi_info.py has been transfered from our local host to remote host.

Next step will be first deleting a file and then deleting a directory.

To delete a file we use "rm filename" command

```shell
cc@cp3793-nyu-edu-fount:~/chameleon$ rm chi_info.py
cc@cp3793-nyu-edu-fount:~/chameleon$ ls
cc@cp3793-nyu-edu-fount:~/chameleon$ ls
hello.txt
```

Next we will try deleting the complete directory.

To delete a directory we use "rm -r directory" command.

```shell
cc@cp3793-nyu-edu-fount:~/chameleon$ cd ..
cc@cp3793-nyu-edu-fount:~/$ rm -r chameleon
cc@cp3793-nyu-edu-fount:~/$ ls
cc@cp3793-nyu-edu-fount:~/$
```
:::

Now we don't have our chameleon directory.

But we have the same directory in our local. So, next we will try to transfer the directory from our local to remote host.

Open the local terminal in another tab.

and let's use the SCP command to recursively transfer the entire chameleon directory to our remote host.

```shell
user@username:~$ scp -r user/chameleon cc@reserved_fip:/home/cc/
hello.txt                        100%   2.4KB/s   00:00
chi_info.py                      100%   3KB/s   00:00
user@username:~$
```

Let's check if directory is transfered or not.

Open the other terminal where we previously logged in to remote via ssh

```shell
cc@cp3793-nyu-edu-fount:~/$ ls
chameleon
cc@cp3793-nyu-edu-fount:~/$ cd chameleon
cc@cp3793-nyu-edu-fount:~/chameleon$ ls
hello.txt chi-info.py
cc@cp3793-nyu-edu-fount:~/chameleon$
```

From the output above we can see that the entire directory was transfered successfully. 


Run the cells below and you will find the exact scp commands which you can use to perform transfer operation. just provide the path of the file in remote host and entire path of the local host.

::: {.cell .markdown}
**Transfering a file to local host from remote host**


:::


::: {.cell .code}
```python

print(f'scp cc@{reserved_fip}:file_path "local_path"')

```
:::

::: {.cell .markdown}
**Transfering a folder to remote host from local**


:::

::: {.cell .code}
```python

print(f'scp -r cc@{reserved_fip}:folder_path "local_path"')

```
:::

::: {.cell .markdown}
**Transfering a file to local from remote host**


:::

::: {.cell .code}
```python
print(f'scp "local_path" cc@{reserved_fip}:file_path ')

```
:::

::: {.cell .markdown}
**Transfering a folder to local from remote host**


:::

::: {.cell .code}
```python
print(f'scp -r "local_path" cc@{reserved_fip}:folder_path ')
```
:::

::: {.cell .markdown}

Use -i "key_path" if your Chameleon key is not in the default location

:::


