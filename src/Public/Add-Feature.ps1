function Add-Feature {

    <#
    
    .SYNOPSIS
    Adds a new feature to a roadmap.

    .DESCRIPTION
    Creates and adds a feature to a previously created roadmap object.

    .EXAMPLE

    PS> $Roadmap = New-ArchRoadmap -Title MyRoadmap
    PS> $Roadmap | Add-ArchFeature -Id 4711 -Title MyFeature

    #>

    [CmdletBinding()]
    param (
        # The roadmap, the feature is added to.
        [Parameter(ValueFromPipeline, Mandatory)]
        [ValidateNotNull()]
        $Roadmap,

        # The identifier of the feature. E.g. the ticket number.
        [Parameter(Mandatory, Position=0)]
        [ValidateNotNullOrEmpty()]
        [string] $Id,

        # The title of the feature.
        [Parameter(Mandatory, Position=1)]
        [ValidateNotNullOrEmpty()]
        [string] $Title,

        # A link to the feature in the agile board.
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string] $Link,

        # Features or milestones that must be completed, before the feature can be implemented.
        [Parameter()]
        [string[]] $DependsOn,

        # Switch that specifies, if the feature should be returned instead of only added to the roadmap.
        [Parameter()]
        [switch] $PassThru
    )

    process {
        $feature = [PSCustomObject]@{
            Id    = $Id
            Title = $Title
        }

        if ( $Link ) {
            $feature | Add-Member Link $Link
        }

        if ( $DependsOn ) {
            $feature | Add-Member Dependencies $DependsOn
        }

        $Roadmap.Features += $feature

        if ( $PassThru.IsPresent ) {
            Write-Output $feature
        }
    }
}