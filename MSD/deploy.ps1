$RGTemplate = "$PSScriptRoot\azuredeploy.json"

<#
# Site 1

$RG1Name = "ARM-MSD-Site1"
$RG1Location = "West Europe"
$RG1Parameters = "$PSScriptRoot\site1.parameters.json"
New-AzureRmResourceGroup -Name $RG1Name -Location $RG1Location
New-AzureRmResourceGroupDeployment -Name "initial" -ResourceGroupName $RG1Name -TemplateFile $RGTemplate -TemplateParameterFile $RG1Parameters -Verbose

$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName $RG1Name -Name vnet
Add-AzureRmVirtualNetworkSubnetConfig -Name 'GatewaySubnet' -AddressPrefix 10.1.3.0/28 -VirtualNetwork $vnet
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet

$gwpip= New-AzureRmPublicIpAddress -Name gwPIP -ResourceGroupName $RG1Name -Location 'West Europe' -AllocationMethod Dynamic
$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName $RG1Name -Name vnet
$subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name 'GatewaySubnet' -VirtualNetwork $vnet
$gwipconfig = New-AzureRmVirtualNetworkGatewayIpConfig -Name gwipconfig -SubnetId $subnet.Id -PublicIpAddressId $gwpip.Id 
New-AzureRmVirtualNetworkGateway -Name vpnGW -ResourceGroupName $RG1Name -Location $RG1Location -IpConfigurations $gwipconfig -GatewayType Vpn -VpnType RouteBased 
#>

# Site 2
$RG2Name = "ARM-MSD-Site2"
$RG2Location = "North Europe"
$RG2Parameters = "$PSScriptRoot\site2.parameters.json"
New-AzureRmResourceGroup -Name $RG2Name -Location $RG2Location
New-AzureRmResourceGroupDeployment -Name "initial" -ResourceGroupName $RG2Name -TemplateFile $RGTemplate -TemplateParameterFile $RG2Parameters -Verbose 

$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName $RG2Name -Name vnet
Add-AzureRmVirtualNetworkSubnetConfig -Name 'GatewaySubnet' -AddressPrefix 10.2.3.0/28 -VirtualNetwork $vnet
Set-AzureRmVirtualNetwork -VirtualNetwork $vnet

$gwpip= New-AzureRmPublicIpAddress -Name gwPIP -ResourceGroupName $RG2Name -Location 'North Europe' -AllocationMethod Dynamic
$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName $RG2Name -Name vnet
$subnet = Get-AzureRmVirtualNetworkSubnetConfig -Name 'GatewaySubnet' -VirtualNetwork $vnet
$gwipconfig = New-AzureRmVirtualNetworkGatewayIpConfig -Name gwipconfig -SubnetId $subnet.Id -PublicIpAddressId $gwpip.Id 
New-AzureRmVirtualNetworkGateway -Name vpnGW -ResourceGroupName $RG2Name -Location $RG2Location -IpConfigurations $gwipconfig -GatewayType Vpn -VpnType RouteBased 