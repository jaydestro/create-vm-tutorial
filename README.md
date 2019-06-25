
# A basic VM creation script that asks for:

* Location - Where you want this to live - `az account list-locations  -o json` for a list
* Resource Group (Creates one for you or uses the one you specify)
* VM Name - This will be the name for the VM that is created.
* Subscription ID - you can get this by running `az account show --out json` 

You can find the blog post that explains what all of this does by going to:

https://dev.to/azure/azure-cloud-shell-tips-for-sysadmins-part-ii-using-the-cloud-shell-tools-to-migrate-3ka8


Note the following defaults:

```
--admin-username azureuser 
--generate-ssh-keys
--image UbuntuLTS
```

Requirements: 

* Azure Account
* Cloud Shell - Bash

# Ansible node install

The Ansible directory provides an npm/node install Ansible playbook.  Install from the Azure Cloud shell with the example host file for inventory and binary exectution:

~/.ansible/hosts

```
[frontend]
ip.of.server
```

```
ansible-playbook --inventory-file=~/.ansible/hosts -u azureuser install_node.yaml
```
