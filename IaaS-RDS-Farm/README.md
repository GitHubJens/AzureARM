# Create Remote Desktop Session Host Farm

This template deploys the following resources in one Resourse Group:

+	Storage Account
+	Virtual Machine that run RD Web Access and Gateway role
+ Virtual Machine that run RD Connection Broker role
+ Virtual Machines that run RD Session Host role
+ Server roles will be configured with Powershell DSC

The template require a resource group with a existing vnet that is set up with dns servers and Active Directory domain. If you don't have a that avilable you can first deploy this using [IaaS-NewActiveDirectory](https://github.com/haavardg/AzureARM/tree/master/IaaS-NewActiveDirectory) ARM template.

### Requierd Parameters:
|Name|Description|
|:---|:---------------------|
|existingResourceGroupName|Existing Resource Group that contains the Virtual Network|
|existingVNETName|Existing VNET that contains the domain controller|
|existingSubnetName|Existing subnet that contains the domain controller|
|existingDomainName|Existing domain name to join RDS servers to|
|DomainJoinAccount|Username of the account with rights to join computers to domain|
|DomainJoinPassword|The password for the domainjoin account|
|dnsLabelPrefix|Unique public DNS prefix for the deployment. The fqdn will look something like '<dnsname>.westeurop.cloudapp.azure.com'. Up to 62 chars, digits or dashes, lowercase, should start with a letter|
|adminUsername|The name of the local administrator of the servers deployed, excluding: Administrator|
|adminPassword|The password for the local administrator account|

### Optional Parameters:
|Name|Default|Description|
|:---|:-------------|:---------------------|
|publicIPAddressName|pip-RDS|Public IP Name|
|RDSHNamePrefix|RDSH|Name prefix for the Session Host, name will be followed by a number based on how many session host servers defined|
|numberOfRdshInstances|2|Number of Session Host to deploy|
|RDSHSize|Standard_D2|The size of the session host VMs|
|RDWAName|RDWA|Name of the RD Web Access and Gateway server|
|RDWASize|Standard_D1|Size of the RD Web Access and Gateway server|
|RDCBName|RDCB|Name of the RD Connection Broker server|
|RDCBSize|Standard_D1|Size of the RD Connection Broker server|
|imageSKU|2012-R2-Datacenter|Windows server SKU|


### Deploy:
#### www.azuredeploy.net
[![Deploy to Azure](http://azuredeploy.net/deploybutton.png)](https://azuredeploy.net/)

#### portal.azure.com
[![Deploy to Azure](http://azuredeploy.net/deploybutton.png)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fhaavardg%2FAzureARM%2Fmaster%2FIaaS-RDS-Farm%2Fazuredeploy.json)
