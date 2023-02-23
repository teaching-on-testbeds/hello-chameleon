
::: {.cell .markdown}
## Exercise: delete resources
Once you are done using the resources, you can delete them by running the cell below. provide the input as "y" if you want to delete the resource.

:::

::: {.cell .code}
```python
DELETE = input("Are you sure you want to delete? y/n")

if DELETE == "y":
    chi.server.delete_server(server_id)
    ip_details = chi.network.get_floating_ip(reserved_fip)
    chi.neutron().delete_floatingip(ip_details["id"])
```
:::

