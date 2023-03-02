
::: {.cell .markdown}
## Exercise: transfer files to and from resources

While working on a remote host, we will often want to transfer files from the remote host to our local filesystem, or vice versa.

To move data back and forth between your laptop and a remote system that you access with _ssh_, we can use _scp_. The syntax is:

```shell
scp [OPTIONS] SOURCE DESTINATION
```
where `SOURCE` is the full address of the location where the file is currently llocated, and `DESTINATION` is the address of the location that you want to copy a file to.


:::

::: {.cell .markdown}

### Transfering files through the local terminal

We previously generated a file on the remote VM, "hello.txt". Now, we'll use `scp` to transfer the file from the remote host to our laptop, make a change to it, then transfer it back.

:::


::: {.cell .markdown}

You will run the `scp` command from your *local* terminal, not on the remote host. If you are still logged in over SSH to the remote host, type 

```shell
exit
```

to return to your local terminal. Check the terminal *prompt* and make sure it reflects that you are executing commands at your local terminal, and not on the Chameleon VM.

:::

::: {.cell .markdown}

Then, we'll need to generate an `scp` command to run, including:

* the location of the key you use to SSH into the remote host, e.g. `~/.ssh/id_rsa_chameleon`
* the username you use to SSH into the remote host, `cc` in this case
* the IP address or hostname you use to SSH into the remote host
* the location of the file you want to copy on the remote host, which is `/home/cc/hello.txt`
* and the location on your laptop to which you want to copy the file. We will copy it to the same location from which you run the scp command (`.` is shorthand for “my current working directory”),


Run the cell below, to generate the `scp` command:
:::

::: {.cell .code}

```python
print(f'scp -i ~/.ssh/id_rsa_chameleon cc@{reserved_fip}:/home/cc/hello.txt .')

```
:::

::: {.cell .markdown}

Copy the command that is printed by the cell above, and make any changes if necessary (e.g. to the key location or name, or to the location in your local filesystem to which the file should be transferred). Then, execute it in your *local* shell. (Note that the `.` at the end is part of the command - don't omit this part!)

The output of this command should show that the file is transferred to your local filesystem:

```text
hello.txt                       100%    1KB     0.1KB/s   00:00
```

:::

::: {.cell .markdown}

When you have successfully transferred "hello.txt" from the remote host to your laptop, locate it in your local filesystem and open it in your preferred text editor. Make a change (any change!) to the file and save it.

Then, we'll transfer it back to the remote host! To transfer it back to the remote host, the `SOURCE` argument will become the location of the file in the local filesystem, and the `DESTINATION` will become the location to which the file should be transferred on the remote VM.

Use the cell below to generate the `scp` command to transfer the file *to* the remote host:

:::

::: {.cell .code}

```python
print(f'scp -i ~/.ssh/id_rsa_chameleon hello.txt cc@{reserved_fip}:/home/cc/')

```
:::

::: {.cell .markdown}

Copy the command that is printed by the cell above, and make any changes (e.g. to the key location or name, or to the location in your local filesystem from which the file should be transferred). Then, execute the command in your *local* shell.

The output of this command should show that the file is transferred to the remote filesystem:

```text
hello.txt                       100%    1KB     0.1KB/s   00:00
```

:::

::: {.cell .markdown}

To validate that the changes you made locally are now reflected in the version of the file that is on the remote host, use the SSH command from the previous section to log in to the remote host again, and run

```shell
cat hello.txt
```

in the SSH session. Verify that your changes appear in the output.


:::




