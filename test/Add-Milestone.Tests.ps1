#Requires -Modules @{ ModuleName='Pester'; ModuleVersion='5.0.0' }

Describe Add-Milestone {

    BeforeAll {
        Import-Module $PSScriptRoot\..\src\PsArchTools.psd1 -Force -ErrorAction Stop
    }

    Context Roadmap {

        BeforeEach {
            $Roadmap = New-ArchRoadmap -Title foobar
        }

        It works {
            $Roadmap | Add-ArchMilestone -Id 4711 -Title foobar
            $Roadmap.Milestones.Count | Should -Be 1
            $Roadmap.Milestones[0].Id | Should -Be 4711
            $Roadmap.Milestones[0].Title | Should -Be foobar
        }

        It works-with-passthru {
            $Milestone = $Roadmap | Add-ArchMilestone -Id 4711 -Title foobar -PassThru
            $Roadmap.Milestones.Count | Should -Be 1
            $Milestone.Id | Should -Be 4711
            $Milestone.Title | Should -Be foobar
        }

        Context Milestone {
    
            BeforeEach {
                $Milestone = $Roadmap | Add-ArchMilestone -Id 4711 -Title foobar -PassThru
            }
    
            It works {
                $Roadmap | Add-ArchMilestone -Id 1337 -Title leet -DependsOn $Milestone.Id
                $Roadmap.Milestones.Count | Should -Be 2
                $Roadmap.Milestones[1].Id | Should -Be 1337
                $Roadmap.Milestones[1].Title | Should -Be leet
            }
    
        }

    }

}