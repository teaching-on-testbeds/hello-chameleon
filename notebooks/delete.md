
::: {.cell .markdown}
## Exercise: delete resources
After utilizing the resources, you can remove them by updating the DELETE parameter to True and executing the cell below.

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

