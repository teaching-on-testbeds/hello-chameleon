
::: {.cell .markdown}
## Exercise: delete resources


Chameleon is a shared facility, and it is important to be mindful of your resource usage and to "free" resources for use by other experimenters when you are finished with them. Your resource will be deleted automatically at the end of your lease, but if you finish sooner, you should delete the compute instance and the lease.

In the cell below, uncomment both lines of code, then run the cell to free 

* the VM and the network address you attached to it.
* and the reservation.

Note that removing the resources will revoke your access to them, and all the information stored on them will be erased. Therefore, ensure that you have saved all your work before deleting the resources.

:::

::: {.cell .code}
```python
# s.delete()
# l.delete()
```
:::

::: {.cell .markdown}

Alternatively, you can delete your instance using the GUI:

* From the [Chameleon website](https://chameleoncloud.org/), click on "Experiment \> KVM@TACC" in the menu (since that is the site that our instance is on).
* Select "Instances" from the menu on the left side.
* Find your instance in the list. If the project that you are part of has many instances, you can filter by name to make it easier to find yours: change the filter criteria to "Instance Name", put part of your instance name in the text input field, and click "Filter".
* Check the box next to *your* instance (make sure not to select someone else's!)
* and press the red "Delete Instances" button.

and you can similarly delete a lease using the GUI:

* Select "Leases" from the menu on the left side.
* Find your lease in the list.
* Check the box next to *your* lease (make sure not to select someone else's!)
* and press the red "Delete Lease" button.


:::

