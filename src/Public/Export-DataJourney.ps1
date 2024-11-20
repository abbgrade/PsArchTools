function Export-DataJourney {

    <#

    .SYNOPSIS
    Exports a data journey.

    .DESCRIPTION
    Serializes a data journey to YAML and writes it to file.

    #>

    [CmdletBinding()]
    param (
        # The title of the data journey that should be exported.
        [Parameter( Mandatory, ValueFromPipelineByPropertyName )]
        [string] $Title,

        # The models of the data journey that should be exported.
        [Parameter( ValueFromPipelineByPropertyName )]
        [PsObject[]] $Models,

        # The layer of the data journey that should be exported.
        [Parameter( ValueFromPipelineByPropertyName )]
        [PsObject[]] $Layer,

        # The flows of data journey that should be exported.
        [Parameter( ValueFromPipelineByPropertyName )]
        [PsObject[]] $Flows,

        # The path of the export file, that should be created.
        [Parameter( Mandatory, ParameterSetName = 'File' )]
        [System.IO.FileInfo] $Path,

        # The path of the export file, that should be created.
        [Parameter( Mandatory, ParameterSetName = 'Directory' )]
        [System.IO.DirectoryInfo] $Directory
    )

    process {
        $content = @{
            Title  = $Title
            Models = $Models
            Layer  = $Layer
            Flows  = $Flows
        }
        switch ($PsCmdlet.ParameterSetName) {
            File {
                $content | ConvertTo-Yaml -Depth 99 | Out-File $Path
            }
            Directory {
                if ( -not $Directory.Exists ) {
                    $Directory.Create()
                }
                Export-DataLayer @content -LayerType journey -ParentDirectory $Directory
            }
            default {
                Write-Error "ParameterSetName '$_' not supported"
            }
        }
    }
}