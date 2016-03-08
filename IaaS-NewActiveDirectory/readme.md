# Create Active Directory Domain in Azure

This template deploys the following resources in one Resourse Group:

+	Storage Account
+	Virtual Network
+	Two Domain Controllers in Avalibility Set
+	Load balancer with public IP and NAT rules for RDP
+	Configure Active Directory using Powershell DSC modules, both PDC and BDC

The template will deploy two domain controllers and configure them using Powershell DSC moduels.

### Requierd Parameters:
|Name|Description|
|:---|:---------------------|
|domainname|Name of the domain|
|adminUsername|Admin username|
|adminPassword|Admin password|
|publicIpDnsName|Public DNS name of the Load balancer|

### Optional Parameters:
|Name|Default|Description|
|:---|:-------------|:---------------------|
|vnetName|vnet-AD|Virtual Network name|
|vnetAddressSpace|10.1.0.0/16|Virtual Network address space in CIDR format|
|vnetSubnetName|Subnet-1|Subnet Name|
|vnetSubnetCidr|10.1.0.0/24|Subnet CIDR address (Example: 10.1.0.0/24)|
|lbName|lb-AD|Load Balancer name|
|publicIPAddressName|pip-AD|Public IP Name|
|pdcName|vm-PDC|Name of the Primary Domain Controller (PDC)|
|pdcIP|10.1.0.4|IP Address of the PDC virtual machine|
|pdcRdpEndpoint|50004|The external TCP port for RDP to the PDC Server|
|bdcName|vm-BDC|Name of the Backup Domain Controller (PDC)|
|bdcIP|10.1.0.5|IP Address of the PDC virtual machine|
|bdcRdpEndpoint|50005|The external TCP port for RDP to the BDC Server|
|availabilitySetName|as-AD|Azure Avalibility Set Name|
|vmSize|Standard D1|Size of the VM|
|imagePublisher|MicrosoftWindowsServer|Image Publisher|
|imageOffer|WindowsServer|Image Offer|
|imageSKU|2012-R2-Datacenter|Image SKU|
|assetLocation|https://github.com/haavardg/AzureARM/raw/master/IaaS-NewActiveDirectory/|The location of resources such as templates and DSC modules that the script is dependent|

### Deploy:
#### azuredeply.net
[![Deploy to Azure](http://azuredeploy.net/deploybutton.png)](https://azuredeploy.net/)

#### portal.azure.com
[![Deploy to Azure](http://azuredeploy.net/deploybutton.png)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fhaavardg%2FAzureARM%2Fmaster%2FIaaS-NewActiveDirectory%2Fazuredeploy.json)
