################################################################################
# Force sync to Azure AD                                                       #
# Author: Cory Burditt                                                         #
# Date: March 16  , 2018                                                       #
# Description: This script Forces a sync with Azure AD of any changes made     #
################################################################################
Import-Module AdSync
Start-ADSyncSyncCycle -PolicyType Delta