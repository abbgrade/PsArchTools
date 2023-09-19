#Requires -Modules @{ ModuleName='Pester'; ModuleVersion='5.0.0' }

Describe ConvertTo-Diagram {

    BeforeAll {
        Import-Module $PSScriptRoot\..\src\PsArchTools.psd1 -Force -ErrorAction Stop
    }

    Context Mini-Roadmap {

        BeforeAll {
            $Roadmap = New-ArchRoadmap 'Diagram Title'
            $Roadmap | Add-ArchFeature A 'do this' -Link 'https://www.github.com'
            $Roadmap | Add-ArchFeature B 'do that' -Link 'https://www.github.com' -DependsOn A
        }

        It works {
            $Roadmap | ConvertTo-ArchDiagram | Should -Be @'
---
title: Diagram Title
---
flowchart LR
    classDef feature fill:#ffcc5c
    classDef milestone fill:#96ceb4
    A["do this"]:::feature
    B["do that"]:::feature
    click A "https://www.github.com" _blank
    click B "https://www.github.com" _blank
    A --> B
'@
        }
    }

    Context Roadmap {

        BeforeAll {
            $Roadmap = New-ArchRoadmap 'Diagram Title'
            $Roadmap | Add-ArchFeature A 'do this' -Link 'https://www.github.com'
            $Roadmap | Add-ArchFeature B 'do that' -Link 'https://www.github.com'
            $Roadmap | Add-ArchMilestone C 'be epic' -DependsOn A, B
            $Roadmap | Add-ArchFeature D 'do whatever' -DependsOn C
            $Roadmap | Add-ArchFeature E 'do what else' -DependsOn C
        }

        It works {
            $Roadmap | ConvertTo-ArchDiagram | Should -Be @'
---
title: Diagram Title
---
flowchart LR
    classDef feature fill:#ffcc5c
    classDef milestone fill:#96ceb4
    A["do this"]:::feature
    B["do that"]:::feature
    D["do whatever"]:::feature
    E["do what else"]:::feature
    C["be epic"]:::milestone
    click A "https://www.github.com" _blank
    click B "https://www.github.com" _blank
    C --> D
    C --> E
    A --> C
    B --> C
'@
        }
    }

    Context DataJourney {

        BeforeAll {
            $Context = New-ArchDataJourney 'Diagram Title'
            $Diner = $Context | Add-ArchDataLayer diner -PassThru
            $Bronze = $Diner | Add-ArchDataLayer bronze -PassThru
            $Bronze | Add-ArchDataModel milk
            $Bronze | Add-ArchDataModel yeast
            $Bronze | Add-ArchDataModel flour
            $Bronze | Add-ArchDataModel beef
        }

        It works {
            $Context | ConvertTo-ArchDiagram | Should -Be @'
---
title: Diagram Title
---
---
title: Diagram Title
---
flowchart TD
    subgraph diner
        subgraph bronze
            milk
            yeast
            flour
            beef
        end
        subgraph silver
            milk --> cheese
            yeast --> cheese
            flour --> bun
            yeast --> bun
            beef --> patty
        end
        subgraph gold
            bun --> burger
            patty --> burger
            cheese --> burger
        end
    end
'@
        }
    }

}