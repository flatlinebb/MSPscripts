### CSS style
$css = "<style>"
###$css = $css + "BODY{text-align:center; background-color:white;}"
$css = $css + "BODY{background-color:peachpuff;}"
$css = $css + "TABLE{font-family:'Lucida Sans Unicode', 'Lucida Grande', Sans-Serif;font-size: 12px;margin: 10px;width: 100%;text-align: center;border-collapse: collapse;border-top: 7px solid #004466;border-bottom: 7px solid #004466;}"
$css = $css + "TH{font-size: 13px;font-weight: normal;padding: 1px;background: #cceeff;border-right: 1px solid #004466;border-left: 1px solid #004466;color: #004466;}"
$css = $css + "TD{padding: 1px;background: #e5f7ff;border-right: 1px solid #004466;border-left: 1px solid #004466;color: #669;hover:black;}"
$css = $css + "TD:hover{ background-color:#004466;}"
$css = $css + "</style>" 
 
$StartDate = (get-date).adddays(-7)
 
$body = Get-WinEvent -FilterHashTable @{LogName='Application','System'; Level=2; StartTime=(Get-Date).AddDays(-7)} -ErrorAction SilentlyContinue | Select-Object TimeCreated,LogName,ProviderName,Id,LevelDisplayName,Message | Sort TimeCreated | ft -AutoSize -Wrap
 
$body | ConvertTo-HTML -Head $css TimeCreated,LogName,ProviderName,Id,LevelDisplayName,Message -verbose > C:\LogAppView.html 

Invoke-Expression C:\LogAppView.html 