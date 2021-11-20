PREFIX=jckuriproject3
RESOURCEGROUP="$PREFIXresourcegroup"
LOCATION="westus"
SERVICEBUS="$PREFIXservicebus"
QUEUE="$PREFIXqueue"

az servicebus namespace create --resource-group $RESOURCEGROUP --name $SERVICEBUS --location $LOCATION --sku Basic

az servicebus queue create --resource-group $RESOURCEGROUP --namespace-name $SERVICEBUS --name $QUEUE --enable-partitioning true

CONNECTIONSTRING=$(az servicebus namespace authorization-rule keys list --resource-group $RESOURCEGROUP --namespace-name $SERVICEBUS --name RootManageSharedAccessKey --query primaryConnectionString --output tsv)

echo "Connection string:"
echo $CONNECTIONSTRING

