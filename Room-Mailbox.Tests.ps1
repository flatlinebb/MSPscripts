BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "Validate-UserSelection" {
    It "returns true for a valid selection" {
        $AllowedAnswers = "Yes,No,Maybe"
        $Selection = "Yes"
        $ErrorMessage = "Invalid Selection"

        $Result = Validate-UserSelection -AllowedAnswers $AllowedAnswers -ErrorMessage $ErrorMessage -Selection $Selection
        $Result | Should -Be $true
    }

    It "returns false for an invalid selection" {
        $AllowedAnswers = "Yes,No,Maybe"
        $Selection = "Invalid"
        $ErrorMessage = "Invalid Selection"

        $Result = Validate-UserSelection -AllowedAnswers $AllowedAnswers -ErrorMessage $ErrorMessage -Selection $Selection
        $Result | Should -Be $false
    }

    It "is case-insensitive" {
        $AllowedAnswers = "Yes,No,Maybe"
        $Selection = "yes"
        $ErrorMessage = "Invalid Selection"

        $Result = Validate-UserSelection -AllowedAnswers $AllowedAnswers -ErrorMessage $ErrorMessage -Selection $Selection
        $Result | Should -Be $true
    }

    It "handles whitespace in AllowedAnswers" {
        $AllowedAnswers = "Yes, No, Maybe"
        $Selection = "No"
        $ErrorMessage = "Invalid Selection"

        $Result = Validate-UserSelection -AllowedAnswers $AllowedAnswers -ErrorMessage $ErrorMessage -Selection $Selection
        $Result | Should -Be $true
    }

    It "returns true when selection matches an answer with surrounding whitespace" {
        $AllowedAnswers = "Yes, No, Maybe"
        $Selection = "No"
        $ErrorMessage = "Invalid Selection"

        $Result = Validate-UserSelection -AllowedAnswers $AllowedAnswers -ErrorMessage $ErrorMessage -Selection $Selection
        $Result | Should -Be $true
    }
}
