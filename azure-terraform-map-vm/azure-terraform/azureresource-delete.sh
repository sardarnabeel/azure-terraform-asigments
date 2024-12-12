#!/bin/bash

# Define resources to delete
RESOURCE_GROUP="test-rg"

# Delete NICs
az network nic delete --resource-group $RESOURCE_GROUP --name vm1-nic
az network nic delete --resource-group $RESOURCE_GROUP --name vm2-nic

# Delete VMs
az vm delete --resource-group $RESOURCE_GROUP --name vm1 --yes
az vm delete --resource-group $RESOURCE_GROUP --name vm2 --yes

# Delete NSGs
az network nsg delete --resource-group $RESOURCE_GROUP --name nsg1
az network nsg delete --resource-group $RESOURCE_GROUP --name nsg2

# Delete Disks
az disk delete --resource-group $RESOURCE_GROUP --name vm1_OsDisk_1_ee446da16dff4a9fa4332c52aa42ebae --yes
az disk delete --resource-group $RESOURCE_GROUP --name vm2_OsDisk_1_b64fbe8af12b4de7ae11fc93af65ae54 --yes
