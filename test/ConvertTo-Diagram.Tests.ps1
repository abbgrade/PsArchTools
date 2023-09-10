#Requires -Modules @{ ModuleName='Pester'; ModuleVersion='5.0.0' }

Describe ConvertTo-Diagram {

    BeforeAll {
        Import-Module $PSScriptRoot\..\src\PsArchTools.psd1 -Force -ErrorAction Stop
    }

    It works {
        ([PSCustomObject]@{
            Title = 'Diagram Title'
            Features = @(
                @{
                    Id = 'A'
                    Title = 'do this'
                    Link = 'https://www.github.com'
                },
                @{
                    Id = 'B'
                    Title = 'do that'
                    Link = 'https://www.github.com'
                },
                @{
                    Id = 'D'
                    Title = 'do whatever'
                    Dependencies = @('C')
                },
                @{
                    Id = 'E'
                    Title = 'do what else'
                    Dependencies = @('C')
                }
            )
            Milestones = @(
                @{
                    Id = 'C'
                    Title = 'be epic'
                    Dependencies = @('A', 'B')
                }
            )
        }) | ConvertTo-ArchDiagram | Should -Be @'
---
title: Diagram Title
---
flowchart
    classDef feature fill:#ffcc5c
    classDef milestone fill:#96ceb4
    A[do this]:::feature
    B[do that]:::feature
    D[do whatever]:::feature
    E[do what else]:::feature
    C[be epic]:::milestone
    click A "https://www.github.com" _blank
    click B "https://www.github.com" _blank
    C --> D
    C --> E
    A --> C
    B --> C
'@
    }

}