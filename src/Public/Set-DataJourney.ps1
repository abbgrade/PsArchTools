function Set-DataJourney {

    <#

    .SYNOPSIS
    Change a data journey.
    
    #>

    [CmdletBinding()]
    param (
        # Data journey to select from.
        [Parameter(Mandatory, ValueFromPipeline)]
        [PSCustomObject] $Journey,
        
        # If present, change the title to this value.
        [Parameter()]
        [string] $Title,

        [Parameter()]
        [switch] $PassThru
    )

    process {

        if ( $Title ) {
            $Journey.Title = $Title
        }

        if ( $PassThru.IsPresent ) {
            Write-Output $Journey
        }
    }

}