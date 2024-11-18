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
        [Parameter( Mandatory, ParameterSetName = 'File' )]
        [ValidateScript({ $_.Exists })]
        [System.IO.FileInfo] $Path,

        # The path of the export file, that should be imported.
        [Parameter( Mandatory, ParameterSetName = 'Directory' )]
        [System.IO.DirectoryInfo] $Directory
    )

    process {

        switch ($PsCmdlet.ParameterSetName) {
            File {
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
            }
            Directory {
                $header = Get-Content -Path ( Join-Path $Directory 'journey.yml' ) -Raw | ConvertFrom-Yaml
                $DataJourney = New-DataJourney @header

                [System.IO.DirectoryInfo] $ModelDirectory = Join-Path $Directory model
                if ( $ModelDirectory.Exists ) {
                    Get-ChildItem $ModelDirectory | ForEach-Object {
                        $model = Import-DataModel -Path $_
                        $model | Add-Member Key $_.BaseName
                        $DataJourney | Add-DataModel -InputObject $model
                    }
                }

                [System.IO.DirectoryInfo] $LayerDirectory = Join-Path $Directory layer
                if ( $LayerDirectory.Exists ) {
                    Get-ChildItem $LayerDirectory | ForEach-Object {
                        $sublayer = Import-DataLayer -Directory $_
                        $sublayer | Add-Member Key $_.BaseName
                        $DataJourney | Add-DataLayer -InputObject $sublayer
                    }
                }

                [System.IO.DirectoryInfo] $FlowDirectory = Join-Path $Directory flows
                if ( $FlowDirectory.Exists ) {
                    Get-ChildItem $FlowDirectory | ForEach-Object {
                        $flow = Import-DataFlow -Path $_
                        $flow | Add-Member Key $_.BaseName
                        $DataJourney | Add-DataFlow -InputObject $flow
                    }
                }
            }
            default {
                Write-Error "ParameterSetName '$_' not supported"
            }
        }

        Write-Output $DataJourney
    }
}