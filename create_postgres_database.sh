PREFIX="jckuriproject3"
RESOURCEGROUP="${PREFIX}resourcegroup"
LOCATION="westus"
SQLSERVER="${PREFIX}sqlserver"
DATABASE="techconfdb"
CLIENTIP=$(curl ifconfig.me)

echo "PREFIX: $PREFIX"
echo "RESOURCEGROUP: $RESOURCEGROUP"
echo "LOCATION: $LOCATION"
echo "SQLSERVER: $SQLSERVER"
echo "DATABASE: $DATABASE"
echo "CLIENT IP: $CLIENTIP"

echo "Creating resource group..."
az group create --name $RESOURCEGROUP --location $LOCATION

echo "Creating database server..."
az postgres server create --location $LOCATION --resource-group $RESOURCEGROUP --name $SQLSERVER --admin-user dbadmin --admin-password @dm!np@ssw0rd --sku-name B_Gen5_1

echo "Creating firewall rule..."
az postgres server firewall-rule create --resource-group $RESOURCEGROUP --server $SQLSERVER --name allips --start-ip-address 0.0.0.0 --end-ip-address 255.255.255.255

echo "Showing database server..."
az postgres server show --resource-group $RESOURCEGROUP --name $SQLSERVER

echo "Creating database..."
az postgres db create --name $DATABASE --resource-group $RESOURCEGROUP --server $SQLSERVER
