#Requires -Modules @{ ModuleName='Pester'; ModuleVersion='5.0.0' }

Describe Export-DataJourney {

    BeforeAll {
        Import-Module $PSScriptRoot\..\src\PsArchTools.psd1 -Force -ErrorAction Stop
    }

    Context DataJourney {

        BeforeAll {
            $Journey = New-ArchDataJourney -Title foobar
            $Layer = $Journey | Add-ArchDataLayer -Key foo -Title bar -PassThru
            $Layer | Add-ArchDataModel -Title mymodel -Class original
            $SubLayer = $Layer | Add-ArchDataLayer -Key mylayer -Title sublayer -PassThru
            $SubLayer | Add-ArchDataModel -Title mysubmodel -Class analysis
            $Layer | Add-ArchDataFlow -Key mm -Title myflow -Description mymodeldescription -Source mymodel -Sink mysubmodel
        }

        It works {
            $path = "$TestDrive\journey.yml"
            $Journey | Export-ArchDataJourney -Path $path -ErrorAction Stop

            $imported = Get-Content -Path $path -Raw | ConvertFrom-Yaml
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
            $imported.Layer[0].Flows[0].Description | Should -Be mymodeldescription
            $imported.Layer[0].Flows[0].Sources.Count | Should -Be 1
            $imported.Layer[0].Flows[0].Sources[0] | Should -Be mymodel
            $imported.Layer[0].Flows[0].Sinks.Count | Should -Be 1
            $imported.Layer[0].Flows[0].Sinks[0] | Should -Be mysubmodel
        }

        It works-to-directory {
            $Journey | Export-ArchDataJourney -Directory $TestDrive\subfolder -ErrorAction Stop

            $imported = Get-Content -Path $TestDrive\subfolder\journey.yml -Raw | ConvertFrom-Yaml
            $imported.Key | Should -BeNullOrEmpty
            $imported.Title | Should -Be foobar
            $imported.Layer | Should -BeNullOrEmpty

            Test-Path $TestDrive\subfolder\layer | Should -Be $true
            ( Get-ChildItem $TestDrive\subfolder\layer ).Count | Should -Be 1
            Test-Path $TestDrive\subfolder\layer\foo\layer.yml | Should -Be $true
            $imported = Get-Content -Path $TestDrive\subfolder\layer\foo\layer.yml -Raw | ConvertFrom-Yaml
            $imported.Key | Should -BeNullOrEmpty
            $imported.Title | Should -Be bar

            ( Get-ChildItem $TestDrive\subfolder\layer\foo\model ).Count | Should -Be 1
            Test-Path $TestDrive\subfolder\layer\foo\model\mymodel.yml | Should -Be $true
            $imported = Get-Content -Path $TestDrive\subfolder\layer\foo\model\mymodel.yml -Raw | ConvertFrom-Yaml
            $imported.Key | Should -BeNullOrEmpty
            $imported.Title | Should -Be mymodel
            $imported.Class | Should -Be original

            ( Get-ChildItem $TestDrive\subfolder\layer\foo\layer ).Count | Should -Be 1
            Test-Path $TestDrive\subfolder\layer\foo\layer\mylayer\layer.yml | Should -Be $true
            $imported = Get-Content -Path $TestDrive\subfolder\layer\foo\layer\mylayer\layer.yml -Raw | ConvertFrom-Yaml
            $imported.Key | Should -BeNullOrEmpty
            $imported.Title | Should -Be sublayer

            ( Get-ChildItem $TestDrive\subfolder\layer\foo\layer\mylayer\model ).Count | Should -Be 1
            Test-Path $TestDrive\subfolder\layer\foo\layer\mylayer\model\mysubmodel.yml | Should -Be $true
            $imported = Get-Content -Path $TestDrive\subfolder\layer\foo\layer\mylayer\model\mysubmodel.yml -Raw | ConvertFrom-Yaml
            $imported.Key | Should -BeNullOrEmpty
            $imported.Title | Should -Be mysubmodel
            $imported.Class | Should -Be analysis

            ( Get-ChildItem $TestDrive\subfolder\layer\foo\flows ).Count | Should -Be 1
            Test-Path $TestDrive\subfolder\layer\foo\flows\mm.yml | Should -Be $true
            $imported = Get-Content -Path $TestDrive\subfolder\layer\foo\flows\mm.yml -Raw | ConvertFrom-Yaml
            $imported.Key | Should -BeNullOrEmpty
            $imported.Title | Should -Be myflow
            $imported.Description | Should -Be mymodeldescription
            $imported.Sources.Count | Should -Be 1
            $imported.Sources[0] | Should -Be mymodel
            $imported.Sinks.Count | Should -Be 1
            $imported.Sinks[0] | Should -Be mysubmodel
        }
    }

}