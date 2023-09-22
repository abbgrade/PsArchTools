function Add-Milestone {

    <#
    
    .SYNOPSIS
    Adds a new milestone to a roadmap.

    .DESCRIPTION
    Creates and adds a milestone to a previously created roadmap object.

    .EXAMPLE

    PS> $Roadmap = New-ArchRoadmap -Title MyRoadmap
    PS> $Roadmap | Add-ArchMilestone -Id 4711 -Title MyMilestone

    #>

    [CmdletBinding()]
    param (
        # The roadmap, the milestone is added to.
        [Parameter(ValueFromPipeline, Mandatory)]
        [ValidateNotNull()]
        $Roadmap,

        # The identifier of the milestone. E.g. the ticket number.
        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string] $Id,

        # The title of the milestone.
        [Parameter(Mandatory, Position = 1)]
        [ValidateNotNullOrEmpty()]
        [string] $Title,

        # Features or milestones that must be completed, before the milestone is reached.
        [Parameter()]
        [string[]] $DependsOn,

        # Switch that specifies, if the milestone should be returned instead of only added to the roadmap.
        [Parameter()]
        [switch] $PassThru
    )

    process {
        $Milestone = [PSCustomObject]@{
            Id    = $Id
            Title = $Title
        }

        if ( $DependsOn ) {
            $Milestone | Add-Member Dependencies $DependsOn
        }

        $Roadmap.Milestones += $Milestone

        if ( $PassThru.IsPresent ) {
            Write-Output $Milestone
        }
    }
}