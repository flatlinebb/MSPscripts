<# 
.Synopsis 
   A PowerShell Nagios script to check the health of Hyper-V replicas. 
.DESCRIPTION 
   A PowerShell Nagios script to check the health of Hyper-V replicas. 
   Using the Hyper-V module we can check for VM's that are primary replicas 
   and check their replication health. If they are not normal then we report 
   back warning or critical depending on the replication health status. 
 
   Usage with NSClient++ 
   --------------------- 
   Add an external command to your nsclient.ini: 
    
   CheckHyperVReplica=cmd /c echo scripts\Check-HyperVReplica.ps1; exit($lastexitcode) | powershell.exe -command - 
 
   Create a nagios service check: 
   $USER1$/check_nrpe -H $HOSTADDRESS$ -u -t 90 -c $ARG1$ 
   ($ARG1$ = CheckHyperVReplica) 
 
.NOTES 
   Created by: Jason Wasser 
   Modified: 7/9/2015 09:53:21 AM  
 
   Version 1.2 
 
   Changelog: 
    * Need to not just include Primary VM's, but Replica's as well. New default is to include Primary and Replica VM's  
      in check. Added switch to include only primary replicas if needed. 
    * Added replication health details to output so we know why the VM repliation is unhealthy. 
 
.EXAMPLE 
   .\Check-Hyper-VReplica.ps1 
   Checks the Hyper-V Replica status of VM's on the local computer and returns status code. 
.EXAMPLE 
   .\Check-Hyper-VReplica.ps1 -ComputerName SERVER01 
   Checks the Hyper-V Replica status of VM's on the remote computer SERVER01 and returns status code. 
#> 
#Requires -Modules Hyper-V 
#Requires -Version 3.0 
[CmdletBinding()] 
Param 
( 
    # Name of the server, defaults to local 
    [Parameter(Mandatory=$false, 
                ValueFromPipelineByPropertyName=$true, 
                Position=0)] 
    [string]$ComputerName=$env:COMPUTERNAME, 
    [int]$returnStateOK = 0, 
    [int]$returnStateWarning = 1, 
    [int]$returnStateCritical = 2, 
    [int]$returnStateUnknown = 3, 
    [switch]$IncludePrimaryReplicaOnly=$false 
) 
 
Begin 
{ 
} 
Process 
{ 
    # Get a list of VM's who are primary replicas whose is not Normal. 
    try { 
        if ($IncludePrimaryReplicaOnly) { 
            $UnhealthyVMs = Measure-VMReplication -ComputerName $ComputerName -ErrorAction Stop | Where-Object {$_.ReplicationMode -eq "Primary" -and $_.ReplicationHealth -ne "Normal"} 
            } 
        else { 
            $UnhealthyVMs = Measure-VMReplication -ComputerName $ComputerName -ErrorAction Stop | Where-Object {$_.ReplicationHealth -ne "Normal"} 
            } 
         
        } 
    catch { 
        Write-Output "Unknown" ; exit $returnStateUnknown 
        } 
    if ($UnhealthyVMs) { 
        # If we have VMs then we need to determine if we need to return critical or warning. 
        $CriticalVMs = $UnhealthyVMs | Where-Object -Property ReplicationHealth -eq "Critical" 
        $WarningVMs = $UnhealthyVMs | Where-Object -Property ReplicationHealth -eq "Warning" 
        if ($CriticalVMs) { 
            Write-Output "Critical for $($CriticalVMs.Name). $($CriticalVMs.ReplicationHealthDetails)" ; exit $returnStateCritical 
            } 
        elseif ($WarningVMs) { 
            Write-Output "Warning for $($WarningVMs.Name). $($WarningVMs.ReplicationHealthDetails)" ; exit $returnStateWarning 
            } 
        else { 
            Write-Output "Unknown" ; exit $returnStateUnknown 
            } 
        } 
    else { 
        # No Replication Problems Found 
        Write-Output "Normal" ; exit $returnStateOK 
        } 
} 
End 
{ 
}