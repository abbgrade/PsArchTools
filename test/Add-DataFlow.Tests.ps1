#Requires -Modules @{ ModuleName='Pester'; ModuleVersion='5.0.0' }

Describe Add-DataFlow {

    BeforeAll {
        Import-Module $PSScriptRoot\..\src\PsArchTools.psd1 -Force -ErrorAction Stop
    }

    Context DataJourney {

        BeforeEach {
            $Journey = New-ArchDataJourney -Title foo
        }

        It works {
            $Journey | Add-ArchDataFlow -Title foobar -Source foo -Sink bar
            $Journey.Flows.Count | Should -Be 1
            $Journey.Flows[0].Title | Should -Be foobar
            $Journey.Flows[0].Sources | Should -Be foo
            $Journey.Flows[0].Sinks | Should -Be bar
        }

        It works-by-position {
            $Journey | Add-ArchDataFlow foobar -Source foo -Sink bar
            $Journey.Flows.Count | Should -Be 1
            $Journey.Flows[0].Title | Should -Be foobar
            $Journey.Flows[0].Sources | Should -Be foo
            $Journey.Flows[0].Sinks | Should -Be bar
        }

    }

}