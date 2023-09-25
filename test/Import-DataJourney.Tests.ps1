#Requires -Modules @{ ModuleName='Pester'; ModuleVersion='5.0.0' }

Describe Import-DataJourney {

    BeforeAll {
        Import-Module $PSScriptRoot\..\src\PsArchTools.psd1 -Force -ErrorAction Stop
    }

    Context Export {

        BeforeAll {
            
            $ExportPath = "$TestDrive\journey.yml"
            Set-Content -Path $ExportPath -Value @'
Title: foobar
Layer: []
Models: []
Flows: []
'@
        }

        It works {
            $Journey = Import-ArchDataJourney -Path $ExportPath

            $Journey.Title | Should -Be foobar
            $Journey.Layer | Should -Be @()

            $Journey | ConvertTo-ArchDiagram -ErrorAction Stop
        }
    }

    Context EmptyExport {

        BeforeAll {
            
            $ExportPath = "$TestDrive\journey.yml"
            Set-Content -Path $ExportPath -Value @'
Title: foobar
'@
        }

        It works {
            $Journey = Import-ArchDataJourney -Path $ExportPath

            $Journey.Title | Should -Be foobar
            $Journey.Layer | Should -Be @()

            $Journey | ConvertTo-ArchDiagram -ErrorAction Stop
        }
    }

    Context EmptyLayerExport {

        BeforeAll {
            
            $ExportPath = "$TestDrive\journey.yml"
            Set-Content -Path $ExportPath -Value @'
Title: foo
Layer:
 - Key: bar
'@
        }

        It works {
            $Journey = Import-ArchDataJourney -Path $ExportPath

            $Journey.Title | Should -Be foo
            $Journey.Layer.Count | Should -Be 1
            $Journey.Layer[0].Key | Should -Be bar

            $Journey | ConvertTo-ArchDiagram -ErrorAction Stop
        }
    }
}