
::: {.cell .markdown}
## Exercise: transfer files to and from resources

To securely transfer files between a local and a remote host, we will use the command-line tool called Secure Copy (SCP), which uses the Secure Shell (SSH) protocol for encryption and authentication. SCP provides a secure method for transferring files over a network, ensuring that data remains protected during the transfer process.

:::

::: {.cell .markdown}
### Transfering a file to remote host from local


:::

::: {.cell .code}
```python

print(f'scp cc@{reserved_fip}:file_path "local_path"')

```
:::

::: {.cell .markdown}
### Transfering a folder to remote host from local


:::

::: {.cell .code}
```python

print(f'scp -r cc@{reserved_fip}:folder_path "local_path"')

```
:::

::: {.cell .markdown}
### Transfering a file to local from remote host


:::

::: {.cell .code}
```python
print(f'scp "local_path" cc@{reserved_fip}:file_path ')

```
:::

::: {.cell .markdown}
### Transfering a folder to local from remote host


:::

::: {.cell .code}
```python
print(f'scp -r "local_path" cc@{reserved_fip}:folder_path ')
```
:::

::: {.cell .markdown}

Use -i "key_path" if your Chameleon key is not in the default location

:::


