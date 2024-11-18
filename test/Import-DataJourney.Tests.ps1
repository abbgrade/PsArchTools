#Requires -Modules @{ ModuleName='Pester'; ModuleVersion='5.0.0' }

Describe Import-DataJourney {

    BeforeAll {
        Import-Module $PSScriptRoot\..\src\PsArchTools.psd1 -Force -ErrorAction Stop
    }

    Context FileExport {

        Context Export {

            BeforeAll {

                $ExportPath = "$TestDrive/journey.yml"
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

                $ExportPath = "$TestDrive/journey.yml"
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

    Context DirectoryExport {

        BeforeAll {
            $Journey = New-ArchDataJourney -Title foobar
            $Layer = $Journey | Add-ArchDataLayer -Key foo -Title bar -PassThru
            $Layer | Add-ArchDataModel -Title mymodel -Class original
            $SubLayer = $Layer | Add-ArchDataLayer -Key mylayer -Title sublayer -PassThru
            $SubLayer | Add-ArchDataModel -Title mysubmodel -Class analysis
            $Layer | Add-ArchDataFlow -Key mm -Title myflow -Source mymodel -Sink mysubmodel

            $Journey | Export-ArchDataJourney -Directory $TestDrive -ErrorAction Stop
        }

        It works {
            $imported = Import-ArchDataJourney -Directory $TestDrive -ErrorAction Stop

            $imported.Title | Should -Be foobar
            $imported.Layer.Count | Should -Be 1
            $imported.Layer[0].Key | Should -Be foo
            $imported.Layer[0].Title | Should -Be bar
            $imported.Layer[0].Models.Count | Should -Be 1
            $imported.Layer[0].Models[0].Title | Should -Be mymodel
            $imported.Layer[0].Models[0].Class | Should -Be original
            $imported.Layer[0].Layer.Count | Should -Be 1
            $imported.Layer[0].Layer[0].Key | Should -Be mylayer
            $imported.Layer[0].Layer[0].Title | Should -Be sublayer
            $imported.Layer[0].Layer[0].Models.Count | Should -Be 1
            $imported.Layer[0].Layer[0].Models[0].Title | Should -Be mysubmodel
            $imported.Layer[0].Layer[0].Models[0].Class | Should -Be analysis
            $imported.Layer[0].Flows.Count | Should -Be 1
            $imported.Layer[0].Flows[0].Key | Should -Be mm
            $imported.Layer[0].Flows[0].Title | Should -Be myflow
            $imported.Layer[0].Flows[0].Sources.Count | Should -Be 1
            $imported.Layer[0].Flows[0].Sources[0] | Should -Be mymodel
            $imported.Layer[0].Flows[0].Sinks.Count | Should -Be 1
            $imported.Layer[0].Flows[0].Sinks[0] | Should -Be mysubmodel
        }
    }
}