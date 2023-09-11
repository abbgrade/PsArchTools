function Add-Milestone {

    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline, Mandatory)]
        [ValidateNotNull()]
        $Roadmap,

        [Parameter(Mandatory, Position=0)]
        [ValidateNotNullOrEmpty()]
        [string] $Id,

        [Parameter(Mandatory, Position=1)]
        [ValidateNotNullOrEmpty()]
        [string] $Title,

        [Parameter()]
        [string[]] $DependsOn,

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