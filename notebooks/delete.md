
::: {.cell .markdown}
## Exercise: delete resources
Once you are done using the resources, you can delete them by changing DELETE = True and run the cell below.

Once you delete your resources, you will no longer have access to them, and all the data on them will be deleted. Make sure that you have saved everything before you delete your resources.
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

