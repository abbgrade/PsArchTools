#Requires -Modules @{ ModuleName='Pester'; ModuleVersion='5.0.0' }

Describe Add-FeatureState {

    BeforeAll {
        Import-Module $PSScriptRoot\..\src\PsArchTools.psd1 -Force -ErrorAction Stop
    }

    Context Mini-Roadmap {

        BeforeEach {
            $Roadmap = New-ArchRoadmap 'Diagram Title'
        }

        It has-default-state {
            $Roadmap.FeatureStates.Count | Should -Be 1
            $Roadmap.FeatureStates[''] | Should -Be 'fill:#ffcc5c'
        }

        It adds-state {
            $Roadmap | Add-ArchFeatureState -State Done -Style 'fill:#68ba6a'
            $Roadmap.FeatureStates.Count | Should -Be 2
            $Roadmap.FeatureStates.Done | Should -Be 'fill:#68ba6a'
        }

        It adds-default-state {
            $Roadmap | Add-ArchFeatureState -Style 'fill:#e0f1e1'
            $Roadmap.FeatureStates.Count | Should -Be 1
            $Roadmap.FeatureStates[''] | Should -Be 'fill:#e0f1e1'
        }
    }
}