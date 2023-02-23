
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

::: {.cell .code}
```python
print('ssh -L 127.0.0.1:8888:127.0.0.1:8888 cc@' + reserved_fip) 
```
:::

::: {.cell .markdown}
If your Chameleon key is not in the default location, you should also specify the path to your key as an argument, using -i.

eg: ssh -L 127.0.0.1:8888:127.0.0.1:8888 cc@129.114.xx.xxx -i "<path_name>"

::: 
