#!/bin/bash

declare RESOURCEGROUP=""
declare SUBSCRIPTION=""
declare FONTENDVMNAME=""
declare LOCATION=""

while getopts ":i:g:n:l:" arg; do
        case "${arg}" in
                i)
                        RESOURCEGROUP=${OPTARG}
                        ;;
                g)
                        SUBSCRIPTION=${OPTARG}
                        ;;
                n)
                        FONTENDVMNAME=${OPTARG}
                        ;;
                l)
                        LOCATION=${OPTARG}
                        ;;
                        
                esac
done

shift $((OPTIND-1))


#Prompt for parameters is some required parameters are missing
if [[ -z "$SUBSCRIPTION" ]]; then
        echo "Your subscription ID can be looked up with the CLI using: az account show --out json "
        echo "Enter your subscription ID:"
        read SUBSCRIPTION
        [[ "${SUBSCRIPTION:?}" ]]
fi

if [[ -z "$RESOURCEGROUP" ]]; then
        echo "Enter a name for a resource group. This script will create a new group "
        read RESOURCEGROUP
        [[ "${RESOURCEGROUP:?}" ]]
fi

if [[ -z "$LOCATION" ]]; then
        echo "Enter the location for this deployment"
       echo "List of available regions is 'centralus,eastasia,southeastasia,eastus,eastus2,westus,westus2,northcentralus,southcentralus,westcentralus,northeurope,westeurope,japaneast,japanwest,brazilsouth,australiasoutheast,australiaeast,westindia,southindia,centralindia,canadacentral,canadaeast,uksouth,ukwest,koreacentral,koreasouth,francecentral,southafricanorth,uaenorth"
        read LOCATION
fi

if [[ -z "$FONTENDVMNAME" ]]; then
        echo "Enter front end VM name:"
        read FONTENDVMNAME
fi

echo 'creating your resource group' 

 az group create --name $RESOURCEGROUP --subscription $SUBSCRIPTION -l $LOCATION

sleep 5

echo 'creating your frontend vm' 
az vm create --resource-group $RESOURCEGROUP --name $FONTENDVMNAME --public-ip-address-dns-name $FONTENDVMNAME --image UbuntuLTS --admin-username azureuser --generate-ssh-keys

sleep 30

echo 'network ports'

az vm open-port --port 80 --priority 199 --resource-group $RESOURCEGROUP --name $FONTENDVMNAME
sleep 4

echo 'You're done, when you're ready to delete this, execute this command in Cloud Shell'
echo "az group delete -g $RESOURCEGROUP"
