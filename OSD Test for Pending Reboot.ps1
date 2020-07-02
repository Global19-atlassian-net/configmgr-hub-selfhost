﻿function Test-PendingReboot
{
 if (Get-ChildItem "HKLM:\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending" -EA SilentlyContinue) { return $true }
 if (Get-Item "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired" -EA SilentlyContinue) { return $true }
 if (Get-ItemProperty "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager" -Name PendingFileRenameOperations -EA SilentlyContinue) { return $true }
 try { 
   $util = [wmiclass]"\\.\root\ccm\clientsdk:CCM_ClientUtilities"
   $status = $util.DetermineIfRebootPending()
   if(($status -ne $null) -and $status.RebootPending){
     return $true
   }
 }catch{}
 
 return $false
}
Test-PendingReboot
