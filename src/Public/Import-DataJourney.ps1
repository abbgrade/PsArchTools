function Import-DataJourney {

    <#
    
    .SYNOPSIS
    Imports a data journey.

    .DESCRIPTION
    Reads an export from file and deserializes it to a data journey.

    #>

    [CmdletBinding()]
    param (

        # The path of the export file, that should be imported.
        [Parameter( Mandatory )]
        [ValidateScript({ Test-Path $_ })]
        [System.IO.FileInfo] $Path
    )

    process {
        $DataJourney = [PSCustomObject] ( Get-Content -Path $Path -Raw | ConvertFrom-Yaml )

        if ( -not $DataJourney.Layer ) {
            $DataJourney | Add-Member Layer @() -Force
        }

        if ( -not $DataJourney.Models ) {
            $DataJourney | Add-Member Models @() -Force
        }

        if ( -not $DataJourney.Flows ) {
            $DataJourney | Add-Member Flows @() -Force
        }

        Write-Output $DataJourney
    }
}