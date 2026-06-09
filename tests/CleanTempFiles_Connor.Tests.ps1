$ScriptPath = "$PSScriptRoot\..\CleanTempFiles_Connor.ps1"
. $ScriptPath

Describe "delete-files" {
    It "should find files, log their sizes, and remove them" {
        # Setup
        $script:logdelete = "mock_log.txt"

        $mockFile1 = [PSCustomObject]@{
            FullName = "C:\Fake\Dir\file1.log"
            Length = 2048
        }
        $mockFile2 = [PSCustomObject]@{
            FullName = "C:\Fake\Dir\file2.log"
            Length = 1024
        }
        $mockFiles = @($mockFile1, $mockFile2)

        # Mocking Get-ChildItem for the target folder search AND for getting file length
        Mock Get-ChildItem {
            if ($Path -and $Path -eq "C:\Fake\Dir") {
                return $mockFiles
            } else {
                # It's called on the file object itself in the function: Get-ChildItem $file
                return $Path
            }
        }

        Mock Get-Date { return "1/1/2024 12:00:00 PM" }
        Mock Out-File {}
        Mock Remove-Item {}

        # Act
        delete-files -Extension "*.log" -TargetFolder "C:\Fake\Dir"

        # Assert
        Assert-MockCalled -CommandName Get-ChildItem -ParameterFilter { $Path -eq "C:\Fake\Dir" -and $Include -eq "*.log" -and $Recurse } -Times 1
        Assert-MockCalled -CommandName Out-File -ParameterFilter { $Append -and $FilePath -eq "mock_log.txt" } -Times 2
        Assert-MockCalled -CommandName Remove-Item -ParameterFilter { $Path -eq "C:\Fake\Dir\file1.log" -and $Force -and $Confirm -eq $false } -Times 1
        Assert-MockCalled -CommandName Remove-Item -ParameterFilter { $Path -eq "C:\Fake\Dir\file2.log" -and $Force -and $Confirm -eq $false } -Times 1
    }
}
