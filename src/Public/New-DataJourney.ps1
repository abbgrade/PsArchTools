function New-DataJourney {

    <#
    
    .SYNOPSIS
    Creates a new data journey.

    .DESCRIPTION
    A data journey describes the data layers with models and the data flows in between.

    #>

    [CmdletBinding()]
    [OutputType('DataJourney')]
    param (
        # Specifies the title.
        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [string] $Title
    )

    process {
        [PSCustomObject]@{
            Title   = $Title
            Layer   = @()
            Models  = @()
            Flows   = @()
        }
    }

}