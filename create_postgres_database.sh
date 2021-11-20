PREFIX=jckuriproject3
RESOURCEGROUP="$PREFIXresourcegroup"
LOCATION="westus"
SQLSERVER="$PREFIXsqlserver"
DATABASE="techconfdb"
CLIENTIP=$(curl ifconfig.me)

echo "CLIENT IP:"
echo $CLIENTIP

az group create --name $RESOURCEGROUP --location $LOCATION

az postgres server create --location $LOCATION --resource-group $RESOURCEGROUP --name $SQLSERVER --admin-user dbadmin --admin-password @dm!np@ssw0rd

az postgres server firewall-rule create --resource-group $RESOURCEGROUP --server $SQLSERVER --name allips --start-ip-address 0.0.0.0 --end-ip-address 255.255.255.255

az postgres server show --resource-group $RESOURCEGROUP --name $SQLSERVER

az postgres db create --name $DATABASE --resource-group $RESOURCEGROUP --server $SQLSERVER
