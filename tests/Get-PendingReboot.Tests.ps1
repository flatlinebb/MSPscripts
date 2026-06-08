$ScriptPath = "$PSScriptRoot/../Get-PendingReboot.ps1"

Describe "Get-PendingReboot" {
    BeforeAll {
        . $ScriptPath
    }

    Context "When Invoke-WmiMethod throws UnauthorizedAccessException" {
        It "Should output a warning if CcmExec service is not running" {
            # Mock Get-WmiObject for Win32_OperatingSystem and StdRegProv
            Mock Get-WmiObject {
                if ($Class -eq 'Win32_OperatingSystem') {
                    return [PSCustomObject]@{ BuildNumber = '7601'; CSName = 'TestPC' }
                }
                if ($Class -eq 'StdRegProv') {
                    $mockReg = New-Object PSObject
                    $mockReg | Add-Member -MemberType ScriptMethod -Name EnumKey -Value { param($hklm, $path) return [PSCustomObject]@{ sNames = @() } }
                    $mockReg | Add-Member -MemberType ScriptMethod -Name GetMultiStringValue -Value { param($hklm, $path, $name) return [PSCustomObject]@{ sValue = $null } }
                    $mockReg | Add-Member -MemberType ScriptMethod -Name GetStringValue -Value { param($hklm, $path, $name) return 'TestPC' }
                    return $mockReg
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
            Get-PendingReboot -ComputerName 'TestPC'

            # Assert
            Assert-MockCalled Write-Warning -Times 1 -ParameterFilter {
                $Message -match 'TestPC: Error - CcmExec service is not running.'
            }
        }
    }
}
