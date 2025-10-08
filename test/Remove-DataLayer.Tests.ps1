#Requires -Modules @{ ModuleName='Pester'; ModuleVersion='5.0.0' }

Describe Remove-DataLayer {

    BeforeAll {
        Import-Module $PSScriptRoot\..\src\PsArchTools.psd1 -Force -ErrorAction Stop
    }

    Context DataJourney {

        BeforeEach {
            $Journey = New-ArchDataJourney -Title foo
            $Layer = $Journey | Add-ArchDataLayer -Key foo -Title 'f o o' -PassThru
            $Layer | Add-ArchDataLayer -Key bar -Title 'b a r'
            $Layer | Add-ArchDataLayer -Key baz -Title 'b a z'
        }

        It works {
            $Journey | Remove-ArchDataLayer -Key bar, baz -Recurse
            $Layer.Layer.Count | Should -Be 0
        }

    }

}