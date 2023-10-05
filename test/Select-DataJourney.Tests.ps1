#Requires -Modules @{ ModuleName='Pester'; ModuleVersion='5.0.0' }

Describe Select-DataJourney {

    BeforeAll {
        Import-Module $PSScriptRoot\..\src\PsArchTools.psd1 -Force -ErrorAction Stop
    }

    Context DataJourney {

        BeforeAll {
            $Journey = New-ArchDataJourney 'Diagram Title'
            $Diner = $Journey | Add-ArchDataLayer diner -PassThru

            $Bronze = $Diner | Add-ArchDataLayer bronze -PassThru
            $Bronze | Add-ArchDataModel milk exchange
            $Bronze | Add-ArchDataModel yeast exchange
            $Bronze | Add-ArchDataModel flour exchange
            $Bronze | Add-ArchDataModel beef exchange-original

            $Silver = $Diner | Add-ArchDataLayer silver -PassThru
            $Silver | Add-ArchDataModel cheese retention-original
            $Diner | Add-ArchDataFlow making-cheese 'making cheese' -Sink cheese -Source milk, yeast
            $Silver | Add-ArchDataModel bun retention-original
            $Diner | Add-ArchDataFlow bake -Sink bun -Source flour, yeast
            $Silver | Add-ArchDataModel patty retention
            $Diner | Add-ArchDataFlow form -Sink patty -Source beef

            $Gold = $Diner | Add-ArchDataLayer gold -PassThru
            $Gold | Add-ArchDataModel burger analysis
            $Diner | Add-ArchDataFlow fry -Sink burger -Source bun, patty, cheese
        }

        It works {
            $SubJourney = $Journey | Select-ArchDataJourney -Flow fry
            $SubJourney.Layer.Count | Should -Be 1
            $SubJourney.Layer[0].Key | Should -Be diner
            $SubJourney.Layer[0].Flows.Count | Should -Be 1
            $SubJourney.Layer[0].Flows[0].Key | Should -Be fry
        }
    }

}