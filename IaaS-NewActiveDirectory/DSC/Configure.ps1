configuration CreatePDC 
{ 
   param 
   ( 
        [Parameter(Mandatory)]
        [String]$DomainName,

        [Parameter(Mandatory)]
        [System.Management.Automation.PSCredential]$Admincreds,

        [Int]$RetryCount=20,
        [Int]$RetryIntervalSec=30
    ) 
    
    Import-DscResource -ModuleName xActiveDirectory,xStorage, xNetworking
    [System.Management.Automation.PSCredential ]$DomainCreds = New-Object System.Management.Automation.PSCredential ("${DomainName}\$($Admincreds.UserName)", $Admincreds.Password)

    Node localhost
    {
        WindowsFeature DNS 
        { 
            Ensure = "Present" 
            Name = "DNS"
        }
        xDnsServerAddress DnsServerAddress 
        { 
            Address        = '127.0.0.1' 
            InterfaceAlias = 'Ethernet'
            AddressFamily  = 'IPv4'
        }
        xWaitforDisk Disk2
        {
             DiskNumber = 2
             RetryIntervalSec =$RetryIntervalSec
             RetryCount = $RetryCount
        }
        xDisk ADDataDisk
        {
            DiskNumber = 2
            DriveLetter = "F"
            FSLabel ="ADDisk"

        }
        WindowsFeature ADDSInstall 
        { 
            Ensure = "Present" 
            Name = "AD-Domain-Services"
        }  
        xADDomain FirstDS 
        {
            DomainName = $DomainName
            DomainAdministratorCredential = $DomainCreds
            SafemodeAdministratorPassword = $DomainCreds
            DatabasePath = "F:\NTDS"
            LogPath = "F:\NTDS"
            SysvolPath = "F:\SYSVOL"
        } 
   }
} 

configuration CreateBDC
{ 
   param 
    ( 
        [Parameter(Mandatory)]
        [String]$DomainName,

        [Parameter(Mandatory)]
        [System.Management.Automation.PSCredential]$Admincreds,

        [Int]$RetryCount=20,
        [Int]$RetryIntervalSec=30
    ) 
    Import-DscResource -ModuleName xActiveDirectory,xStorage
    
    [System.Management.Automation.PSCredential ]$DomainCreds = New-Object System.Management.Automation.PSCredential ("${DomainName}\$($Admincreds.UserName)", $Admincreds.Password)
   
    Node localhost
    {
        xWaitforDisk Disk2
        {
             DiskNumber = 2
             RetryIntervalSec =$RetryIntervalSec
             RetryCount = $RetryCount
        }
        xDisk ADDataDisk
        {
            DiskNumber = 2
            DriveLetter = "F"
            FSLabel ="ADDisk"

        }
        WindowsFeature ADDSInstall 
        { 
            Ensure = "Present" 
            Name = "AD-Domain-Services"
        } 
        xWaitForADDomain DscForestWait 
        { 
            DomainName = $DomainName 
            DomainUserCredential= $DomainCreds
            RetryCount = $RetryCount 
            RetryIntervalSec = $RetryIntervalSec
        } 
        xADDomainController BDC 
        { 
            DomainName = $DomainName 
            DomainAdministratorCredential = $DomainCreds 
            SafemodeAdministratorPassword = $DomainCreds
            DatabasePath = "F:\NTDS"
            LogPath = "F:\NTDS"
            SysvolPath = "F:\SYSVOL"
        }
   }
} 
