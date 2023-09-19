#Requires -Modules @{ ModuleName='Pester'; ModuleVersion='5.0.0' }

Describe Add-Feature {

    BeforeAll {
        Import-Module $PSScriptRoot\..\src\PsArchTools.psd1 -Force -ErrorAction Stop
    }

    Context Roadmap {

        BeforeEach {
            $Roadmap = New-ArchRoadmap -Title foobar
        }

        It works {
            $Roadmap | Add-ArchFeature -Id 4711 -Title foobar -Link https://localhost
            $Roadmap.Features.Count | Should -Be 1
            $Roadmap.Features[0].Id | Should -Be 4711
            $Roadmap.Features[0].Title | Should -Be foobar
            $Roadmap.Features[0].Link | Should -Be https://localhost
        }

        It works-by-position {
            $Roadmap | Add-ArchFeature 4711 foobar -Link https://localhost
            $Roadmap.Features.Count | Should -Be 1
            $Roadmap.Features[0].Id | Should -Be 4711
            $Roadmap.Features[0].Title | Should -Be foobar
            $Roadmap.Features[0].Link | Should -Be https://localhost
        }

        It works-with-passthru {
            $feature = $Roadmap | Add-ArchFeature -Id 4711 -Title foobar -Link https://localhost -PassThru
            $Roadmap.Features.Count | Should -Be 1
            $feature.Id | Should -Be 4711
            $feature.Title | Should -Be foobar
            $feature.Link | Should -Be https://localhost
        }

        Context Feature {
    
            BeforeEach {
                $Feature = $Roadmap | Add-ArchFeature -Id 4711 -Title foobar -Link https://localhost -PassThru
            }
    
            It works {
                $Roadmap | Add-ArchFeature -Id 1337 -Title leet -Link https://localhost -DependsOn $Feature.Id
                $Roadmap.Features.Count | Should -Be 2
                $Roadmap.Features[1].Id | Should -Be 1337
                $Roadmap.Features[1].Title | Should -Be leet
                $Roadmap.Features[1].Link | Should -Be https://localhost
            }
    
        }

    }

}