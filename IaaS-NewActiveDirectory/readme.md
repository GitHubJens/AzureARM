# Create Active Directory Domain in Azure 

This template deploys the following resources:

+	Storage Account
+	Virtual Network
+	Two Domain Controllers in Avalibility Set
+	Loadballancer with public IP and NAT rules for RDP
+	Configure Activ Directory using DSC, both PDC and BDC

The template will deploy two domain controllers and configure them using DSC based on the parameter input.

### Requierd Parameters:
|Name|Description|
|:---|:---------------------|
|domainname|Name of the domain|
|adminUsername|Admin username|
|adminPassword|Admin password|
|publicIpDnsName|Public DNS name of the Loadbalancer|

### Optional Parameters:
|Name|Default|Description|
|:---|:---------------------|
|vnetName|vnet-AD|VNET name|
|lbName|lb-AD|Load Balancer name|
|publicIPAddressName|pip-AD|Public IP Name|
|pdcName|vm-PDC|Name of the Primary Domain Controller (PDC)|
|bdcName|vm-BDC|Name of the Backup Domain Controller (PDC)|
|vmSize|Standard D1|Size of the VM|
|imagePublisher|MicrosoftWindowsServer|Image Publisher|
|imageOffer|WindowsServer|Image Offer|
|imageSKU|2012-R2-Datacenter|Image SKU|

[![Deploy to Azure](http://azuredeploy.net/deploybutton.png)](https://azuredeploy.net/)