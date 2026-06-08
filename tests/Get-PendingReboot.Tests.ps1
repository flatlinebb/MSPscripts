$ScriptPath = "$PSScriptRoot\..\Get-PendingReboot.ps1"
. $ScriptPath

Describe "Get-PendingReboot" {
    Context "When WMI access fails" {
        It "Should log a warning and continue when Get-WmiObject throws an error" {
            Mock Get-WmiObject { throw "Simulated WMI Error" }
            Mock Write-Warning {}

            Get-PendingReboot -ComputerName "TestPC"

            Assert-MockCalled Write-Warning -Times 1 -ParameterFilter { $Message -like "TestPC: Simulated WMI Error" -or $Message -like "TestPC: *Simulated WMI Error*" }
        }

        It "Should append error to ErrorLog when -ErrorLog is specified" {
            Mock Get-WmiObject { throw "Simulated WMI Error" }
            Mock Write-Warning {}
            Mock Out-File {}

            Get-PendingReboot -ComputerName "TestPC" -ErrorLog "C:\temp\error.log"

            Assert-MockCalled Out-File -Times 1 -ParameterFilter { $FilePath -eq "C:\temp\error.log" -and $InputObject -like "TestPC,*" }
        }
    }
}
