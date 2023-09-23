#Requires -Modules @{ ModuleName='Pester'; ModuleVersion='5.0.0' }

Describe Export-DataJourney {

    BeforeAll {
        Import-Module $PSScriptRoot\..\src\PsArchTools.psd1 -Force -ErrorAction Stop
    }

    Context DataJourney {

        BeforeAll {
            $Journey = New-ArchDataJourney -Title foobar
        }

        It works {
            $path = "$TestDrive\journey.yml"
            $Journey | Export-ArchDataJourney -Path $path

            $imported = Get-Content -Path $path -Raw | ConvertFrom-Yaml
            $imported.Title | Should -Be foobar
            $imported.Layer | Should -Be @()
        }
    }

}