################################################################################
# Force sync to Azure AD                                                       #
# Author: Cory Burditt                                                         #
# Version 1.5                                                                  #
# Date: November 19, 2024                                                      #
# Description: This script Forces a sync with Azure AD of any changes made     #
#                 as well as adding in a function to update the                #
#                 domain controllsers as well                                  #
################################################################################



#Are you admin No then RuN AS ADMIN 
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
  # Relaunch as an elevated process:
  Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
  exit
}

function Update-AllDomainController {
  (Get-ADDomainController -Filter *).Name | Foreach-Object {repadmin /syncall $_ (Get-ADDomain).DistinguishedName /e /A | Out-Null}    
  Start-Sleep 10    
  Get-ADReplicationPartnerMetadata -Target "$env:userdnsdomain" -Scope Domain | Select-Object Server, LastReplicationSuccess

}

Import-Module ADSync
Start-ADSyncSyncCycle -PolicyType Initial
Update-AllDomainController

#Completion notice and exit prompt.
Write-Host ("Completed" )
write-host "Press any key to close..."
[void][System.Console]::ReadKey($true)