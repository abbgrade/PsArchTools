#Requires -Modules @{ ModuleName='Pester'; ModuleVersion='5.0.0' }

Describe Add-DataModel {

    BeforeAll {
        Import-Module $PSScriptRoot\..\src\PsArchTools.psd1 -Force -ErrorAction Stop
    }

    Context DataJourney {

        BeforeEach {
            $Journey = New-ArchDataJourney -Title foo
        }

        It works {
            $Journey | Add-ArchDataModel -Title bar
            $Journey.Models.Count | Should -Be 1
            $Journey.Models[0].Title | Should -Be bar
        }

    }

}