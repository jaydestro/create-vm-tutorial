# A basic VM creation script that asks for:

* Location - Where you want this to live - `az account list-locations  -o json` for a list
* Resource Group (Creates one for you or uses the one you specify)
* VM Name - This will be the name for the VM that is created.
* Subscription ID - you can get this by running `az account show --out json` 

Note the following defaults:

```
--admin-username azureuser 
--generate-ssh-keys
--image UbuntuLTS
```

Requirements: 

* Azure Account
* Cloud Shell - Bash

