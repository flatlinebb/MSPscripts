$ScriptPath = "$PSScriptRoot/../Get-PendingReboot.ps1"

Describe "Get-PendingReboot" {
    BeforeAll {
        . $ScriptPath
    }

    Context "When Invoke-WmiMethod throws UnauthorizedAccessException" {
        It "Should output a warning if CcmExec service is not running" {
            # Mock Get-CimInstance for Win32_OperatingSystem
            Mock Get-CimInstance {
                if ($ClassName -eq 'Win32_OperatingSystem') {
                    return [PSCustomObject]@{ BuildNumber = '7601'; CSName = 'localhost' }
                }
            }

            # Mock Get-Service to simulate CcmExec service stopped
            Mock Get-Service {
                return [PSCustomObject]@{ Status = 'Stopped' }
            }

            # Mock Invoke-WmiMethod to throw UnauthorizedAccessException
            Mock Invoke-WmiMethod {
                throw [System.UnauthorizedAccessException]::new("Access Denied")
            }

            # Mock Write-Warning to track if the specific warning is emitted
            Mock Write-Warning {}

            # Execute
            Get-PendingReboot -ComputerName 'localhost'

            # Assert
            Assert-MockCalled Write-Warning -Times 1 -ParameterFilter {
                $Message -match 'localhost: Error - CcmExec service is not running.'
            }
        }
    }
}
