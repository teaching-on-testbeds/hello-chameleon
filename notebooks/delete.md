
::: {.cell .markdown}
## Exercise: delete resources


Chameleon is a shared facility, and it is important to be mindful of your resource usage and to "free" resources for use by other experimenters when you are finished with them.

In the cell below, change `False` to `True`, then run the cell to free the VM and the network address you attached to it.

Note that removing the resources will revoke your access to them, and all the information stored on them will be erased. Therefore, ensure that you have saved all your work before deleting the resources.

:::

::: {.cell .code}
```python
DELETE = False

if DELETE:
    chi.server.delete_server(server_id)
    ip_details = chi.network.get_floating_ip(reserved_fip)
    chi.neutron().delete_floatingip(ip_details["id"])
```
:::

