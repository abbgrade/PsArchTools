#Requires -Modules @{ ModuleName='Pester'; ModuleVersion='5.0.0' }

Describe Add-DataLayer {

    BeforeAll {
        Import-Module $PSScriptRoot\..\src\PsArchTools.psd1 -Force -ErrorAction Stop
    }

    Context DataJourney {

        BeforeEach {
            $Journey = New-ArchDataJourney -Title foo
        }

        It works {
            $Journey | Add-ArchDataLayer -Title bar
            $Journey.Layer.Count | Should -Be 1
            $Journey.Layer[0].Title | Should -Be bar
        }

    }

}