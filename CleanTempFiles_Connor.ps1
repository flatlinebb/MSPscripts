
#setup and time tracking
$StartDate = Get-Date
$scriptname = "CleanTempFiles.ps1"

$scriptpath = $MyInvocation.MyCommand.Path
$dir = Split-Path $scriptpath
$dir = (Get-Item -Path $dir -Verbose).FullName
$logdelete = "$dir\delete_files_log.txt"

#deleted files piped to it
function delete-files{
Param([string]$Extension, [string]$TargetFolder)
    
    #grabs all files within the target folder with the extension provided
    $files = Get-ChildItem $Targetfolder -Include $Extension -Recurse

    foreach($file in $files){
            #recording statements
            $time = get-date
            $size = Get-ChildItem $file | Select-Object @{Name="Kbytes";Expression={$_.Length / 1Kb}}
            
            "${size},${file}, ${time}"| Out-File -Append $logdelete 
            #removing file statment
            remove-item $file -Force -Confirm:$false

    }
}


##MAIN SETUP FUNCTIONALITY##
##Target files and Extentions
$Tgt1 = 'C:\Windows\Logs\CBS\' 
$ext1 = '*.log'

$Tgt2 = 'C:\Windows\Temp\'
$ext2 = 'cab_*'
##executes the deleting function with the target path and the desired extension
delete-files -TargetFolder $Tgt1 -Extension $ext1
delete-files -TargetFolder $Tgt2 -Extension $ext2


#closing time tracking statements
$EndDate = Get-Date
$TimeSpent = New-TimeSpan -Start $StartDate -End $EndDate
$TotalMinutes = $TimeSpent.TotalMinutes 
$Data = "${scriptname}, ${TotalMinutes}, ${StartDate}, ${EndDate}"
$files ="${dir}\timetracking.txt"
$Data |Out-File -Append $files