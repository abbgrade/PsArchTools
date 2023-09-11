#Requires -Modules @{ ModuleName='Pester'; ModuleVersion='5.0.0' }

Describe New-Roadmap {

    BeforeAll {
        Import-Module $PSScriptRoot\..\src\PsArchTools.psd1 -Force -ErrorAction Stop
    }

    It works {
        $roadmap = New-ArchRoadmap -Title foobar
        $roadmap.Title | Should -Be foobar
        $diagram.Features | Should -Be @()
    }

}