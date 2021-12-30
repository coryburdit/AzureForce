<################################################################################
# Force Full Sync Azure AD                                                     #
# Author: Cory Burditt                                                         #
# Date: December 30, 2021                                                      #
# Description: This script will force a full Sync to Azure AD                  #  
################################################################################>



#Are you admin No then RuN AS ADMIN 
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
  # Relaunch as an elevated process:
  Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
  exit
}

Import-Module ADSync
Start-ADSyncSyncCycle -PolicyType Initial

#Completion notice and exit prompt.
Write-Host ("Completed" )
write-host "Press any key to close..."
[void][System.Console]::ReadKey($true)