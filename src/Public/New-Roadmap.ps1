function New-Roadmap {

    <#
    
    .SYNOPSIS
    Create new roadmap object.

    .DESCRIPTION
    A roadmap object is the basis to add features and milestones before the conversion to a diagram.

    .EXAMPLE

    PS> New-ArchRoadmap -Title MyRoadmap

    #>

    [CmdletBinding()]
    [OutputType('Roadmap')]
    param (
        # Specifies the title.
        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [string] $Title
    )

    process {
        [PSCustomObject]@{
            Title      = $Title
            Features   = @()
            Milestones = @()
        }
    }

}