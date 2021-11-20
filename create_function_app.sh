PREFIX=jckuriproject3
RESOURCEGROUP="$PREFIXresourcegroup"
LOCATION="westus"
STORAGEACCOUNT="$PREFIXstorageaccount"
FUNCTIONAPP="$PREFIXfunctionapp"

az storage account create --name $STORAGEACCOUNT --resource-group $RESOURCEGROUP --location $LOCATION

az functionapp create --resource-group $RESOURCEGROUP --name $FUNCTIONAPP --storage-account $STORAGEACCOUNT --os-type Linux --consumption-plan-location $LOCATION --runtime python

