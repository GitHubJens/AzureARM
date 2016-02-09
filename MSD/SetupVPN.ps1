

New-AzureRmLocalNetworkGateway -Name vpnLocalSite -ResourceGroupName ARM-MSD-Site1 -Location 'West Europe' -GatewayIpAddress '13.69.154.50' -AddressPrefix '10.2.0.0/16'

New-AzureRmLocalNetworkGateway -Name vpnLocalSite -ResourceGroupName ARM-MSD-Site2 -Location 'North Europe' -GatewayIpAddress '137.117.152.74' -AddressPrefix '10.1.0.0/16'


$gateway1 = Get-AzureRmVirtualNetworkGateway -Name vpnGW -ResourceGroupName ARM-MSD-Site1
$local1 = Get-AzureRmLocalNetworkGateway -Name vpnLocalSite -ResourceGroupName ARM-MSD-Site1
New-AzureRmVirtualNetworkGatewayConnection -Name vpnCNs2 -ResourceGroupName ARM-MSD-Site1 -Location 'West Europe' -VirtualNetworkGateway1 $gateway1 -LocalNetworkGateway2 $local1 -ConnectionType IPsec -RoutingWeight 10 -SharedKey 'Data123Azure123'

$gateway2 = Get-AzureRmVirtualNetworkGateway -Name vpnGW -ResourceGroupName ARM-MSD-Site2
$local2 = Get-AzureRmLocalNetworkGateway -Name vpnLocalSite -ResourceGroupName ARM-MSD-Site2
New-AzureRmVirtualNetworkGatewayConnection -Name vpnCNs1 -ResourceGroupName ARM-MSD-Site2 -Location 'North Europe' -VirtualNetworkGateway1 $gateway2 -LocalNetworkGateway2 $local2 -ConnectionType IPsec -RoutingWeight 10 -SharedKey 'Data123Azure123'