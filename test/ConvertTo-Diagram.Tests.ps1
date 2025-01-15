#Requires -Modules @{ ModuleName='Pester'; ModuleVersion='5.0.0' }

Describe ConvertTo-Diagram {

    BeforeAll {
        Import-Module $PSScriptRoot\..\src\PsArchTools.psd1 -Force -ErrorAction Stop
    }

    Context Mini-Roadmap {

        BeforeAll {
            $Roadmap = New-ArchRoadmap 'Diagram Title'
            $Roadmap | Add-ArchFeatureState -Style 'fill:#e0f1e1'
            $Roadmap | Add-ArchFeatureState -State Done -Style 'fill:#68ba6a'
            $Roadmap | Add-ArchFeatureState -State InProgress -Style 'fill:#86c787'
            $Roadmap | Add-ArchFeature A 'do this' -Link 'https://www.github.com' -State Done
            $Roadmap | Add-ArchFeature B 'do that' -Link 'https://www.github.com' -DependsOn A -State InProgress
            $Roadmap | Add-ArchFeature C 'do nothing' -DependsOn B
        }

        It works {
            $Roadmap | ConvertTo-ArchDiagram | Should -Be @'
---
title: Diagram Title
---
flowchart LR
    classDef feature fill:#e0f1e1
    classDef feature_Done fill:#68ba6a
    classDef feature_InProgress fill:#86c787
    classDef milestone fill:#96ceb4
    A["do this"]:::feature_Done
    B["do that"]:::feature_InProgress
    C["do nothing"]:::feature
    click A "https://www.github.com" _blank
    click B "https://www.github.com" _blank
    A --> B
    B --> C
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
            $Diner | Add-ArchDataFlow form -Description 'do not add breadcrumbs or onions' -Sink patty -Source beef

            $Gold = $Diner | Add-ArchDataLayer gold -PassThru
            $Gold | Add-ArchDataModel burger analysis -Description 'very delicious'
            $Diner | Add-ArchDataFlow fry -Sink burger -Source bun, patty, cheese
        }

        It works {
            $Journey | ConvertTo-ArchDiagram | Should -Be @'
---
title: Diagram Title
---
flowchart TD
    classDef layer-1 fill:#eeeeee
    classDef layer-2 fill:#dddddd
    classDef original fill:#ffffff,stroke:#555555,stroke-width:4px
    classDef exchange fill:#ffe6cc,stroke:#d79b00
    classDef exchange-original fill:#ffe6cc,stroke:#d79b00,stroke-width:4px
    classDef analysis fill:#e1d5e7,stroke:#9673a6
    classDef analysis-original fill:#e1d5e7,stroke:#9673a6,stroke-width:4px
    classDef retention fill:#d5e8d4,stroke:#82b366
    classDef retention-original fill:#d5e8d4,stroke:#82b366,stroke-width:4px
    diner:::layer-1
    subgraph diner
        bronze:::layer-2
        silver:::layer-2
        gold:::layer-2
        making-cheese[[making cheese]]
        bake[[bake]]
        form[[form<br><small>do not add breadcrumbs or onions</small>]]
        fry[[fry]]
        milk --> making-cheese
        yeast --> making-cheese
        making-cheese --> cheese
        flour --> bake
        yeast --> bake
        bake --> bun
        beef --> form
        form --> patty
        bun --> fry
        patty --> fry
        cheese --> fry
        fry --> burger
        subgraph bronze
            milk[(milk)]:::exchange
            yeast[(yeast)]:::exchange
            flour[(flour)]:::exchange
            beef[(beef)]:::exchange-original
        end
        subgraph silver
            cheese[(cheese)]:::retention-original
            bun[(bun)]:::retention-original
            patty[(patty)]:::retention
        end
        subgraph gold
            burger[(burger<br><small>very delicious</small>)]:::analysis
        end
    end
'@
        }
    }

    Context EmptyDataJourney {

        BeforeAll {
            $Journey = [PSCustomObject]( @"
Title: foobar
Layer: []
Models: []
Flows: []
"@ | ConvertFrom-Yaml )
        }

        It works {
            $Journey | ConvertTo-ArchDiagram| Should -Be @'
---
title: foobar
---
flowchart TD
    classDef layer-1 fill:#eeeeee
    classDef layer-2 fill:#dddddd
    classDef original fill:#ffffff,stroke:#555555,stroke-width:4px
    classDef exchange fill:#ffe6cc,stroke:#d79b00
    classDef exchange-original fill:#ffe6cc,stroke:#d79b00,stroke-width:4px
    classDef analysis fill:#e1d5e7,stroke:#9673a6
    classDef analysis-original fill:#e1d5e7,stroke:#9673a6,stroke-width:4px
    classDef retention fill:#d5e8d4,stroke:#82b366
    classDef retention-original fill:#d5e8d4,stroke:#82b366,stroke-width:4px
'@
        }
    }
}