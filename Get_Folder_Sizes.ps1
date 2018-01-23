$startFolder = "J:\tevorepository"

$colItems = (Get-ChildItem $startFolder -recurse | Where-Object {$_.PSIsContainer -eq $True})
foreach ($i in $colItems)
    {
        $subFolderItems = (Get-ChildItem $i.FullName | Measure-Object -property length -sum)
        $i.FullName + " -- " + "{0:N2}" -f ($subFolderItems.sum / 1GB) + " GB" | findstr /I /V "repl" 
    }

function New-Pause {
 
	Write-Host "Press any key to continue" -ForegroundColor green
 
	$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

	} 
# end function New-Pause
New-Pause