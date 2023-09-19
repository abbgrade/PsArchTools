#Requires -Modules @{ ModuleName='Pester'; ModuleVersion='5.0.0' }

Describe New-DataJourney {

    BeforeAll {
        Import-Module $PSScriptRoot\..\src\PsArchTools.psd1 -Force -ErrorAction Stop
    }

    It works {
        $journey = New-ArchDataJourney -Title foobar
        $journey.Title | Should -Be foobar
        $journey.Layer | Should -Be @()
    }

}