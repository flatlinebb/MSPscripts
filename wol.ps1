param (\\[String\\]$MACAddrString = $(throw 'No MAC addressed passed, please pass as xx-xx-xx-xx-xx-xx'))
$MACAddr = $macAddrString.split('-') | %\\{ \\[byte\\]('0x' + $_) \\}
if ($MACAddr.Length -ne 6)
\\{
    throw 'MAC address must be in format xx-xx-xx-xx-xx-xx'
\\}
$UDPclient = new-Object System.Net.Sockets.UdpClient
$UDPclient.Connect((\\[System.Net.IPAddress\\]::Broadcast),4000)
$packet = \\[byte\\[\\]\\](,0xFF * 6)
$packet += $MACAddr * 16
\\[void\\] $UDPclient.Send($packet, $packet.Length)
write "Wake-On-Lan magic packet sent to $MACAddrString, length $($packet.Length)"
