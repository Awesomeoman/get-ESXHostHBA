add-PSSnapin VMware.VimAutomation.Core

connect-viserver vCenterServer

$colESXHost = "ESXP001.Awsesomeoblog.com", "ESXP001.Awsesomeoblog.com"

$objOutput = @()
foreach ($objVMHost in $colESXHost) {

  $colHBA = Get-VMhost -Name $objVMhost | Get-VMHostHBA -Type FibreChannel | Select VMHost,Device,@{N="WWN";E={"{0:X}" -f $_.PortWorldWideName}} | Sort VMhost,Device
  
  $objOutput += [PSCustomObject] @{
  
    "ESX Host" = $objVMHost
    "HBAs" = $colhba.Device -join ", "
    "WWNs" = $colHBA.WWN -join ", "
    }
}
$objOutput | Out-GridView