################################################################################
# Force sync to Azure AD                                                       #
# Author: Cory Burditt                                                         #
# Date: March 16  , 2018                                                       #
# Description: This script Forces a sync with Azure AD of any changes made     #
################################################################################


#Are you admin No then RuN AS ADMIN 
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
  # Relaunch as an elevated process:
  Start-Process powershell.exe "-File",('"{0}"' -f $MyInvocation.MyCommand.Path) -Verb RunAs
  exit
}

#The Commands
Import-Module AdSync
Start-ADSyncSyncCycle -PolicyType Delta

#Completion notice and exit prompt.
Write-Host ("Completed" )
write-host "Press any key to close..."
[void][System.Console]::ReadKey($true)