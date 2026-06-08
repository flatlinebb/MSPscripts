$ScriptPath = "$PSScriptRoot\..\Send-WOL.ps1"

Describe "Send-WOL" {
    BeforeAll {
        . $ScriptPath
    }

    Context "Sending WOL packets" {
        It "Should successfully send a WOL packet with MAC 00:11:32:21:2D:11 and IP 192.168.8.255" {
            Mock New-Object {
                [PSCustomObject]@{
                    Connect = { param($ip, $port) }
                    Send    = { param($packet, $length) }
                }
            } -ParameterFilter { $TypeName -eq 'System.Net.Sockets.UdpClient' }

            Send-WOL -mac "00:11:32:21:2D:11" -ip "192.168.8.255"

            Assert-MockCalled New-Object -Times 1 -ParameterFilter { $TypeName -eq 'System.Net.Sockets.UdpClient' }
        }

        It "Should correctly parse various MAC address formats" {
            Mock New-Object {
                [PSCustomObject]@{
                    Connect = { param($ip, $port) }
                    Send    = { param($packet, $length) }
                }
            } -ParameterFilter { $TypeName -eq 'System.Net.Sockets.UdpClient' }

            Send-WOL -mac "00-11-32-21-2D-11" -ip "192.168.8.255"
            Send-WOL -mac "0011.3221.2D11" -ip "192.168.8.255"
            Send-WOL -mac "001132212D11" -ip "192.168.8.255"

            Assert-MockCalled New-Object -Times 3 -ParameterFilter { $TypeName -eq 'System.Net.Sockets.UdpClient' }
        }

        It "Should throw an exception if an invalid short MAC address is provided" {
            Mock New-Object {
                [PSCustomObject]@{
                    Connect = { param($ip, $port) }
                    Send    = { param($packet, $length) }
                }
            } -ParameterFilter { $TypeName -eq 'System.Net.Sockets.UdpClient' }

            { Send-WOL -mac "1234" } | Should -Throw
        }
    }
}
