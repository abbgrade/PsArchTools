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
            $Journey | Add-ArchDataLayer -Key bar -Title 'b a r'
            $Journey.Layer.Count | Should -Be 1
            $Journey.Layer[0].Key | Should -Be bar
            $Journey.Layer[0].Title | Should -Be 'b a r'
        }

        It works-by-position {
            $Journey | Add-ArchDataLayer bar 'b a r'
            $Journey.Layer.Count | Should -Be 1
            $Journey.Layer[0].Key | Should -Be bar
            $Journey.Layer[0].Title | Should -Be 'b a r'
        }

    }

}