function Export-DataJourney {

    <#
    
    .SYNOPSIS
    Exports a data journey.

    .DESCRIPTION
    Serializes a data journey to YAML and writes it to file.

    #>

    [CmdletBinding()]
    param (

        # The data journey that should be exported.
        [Parameter( Mandatory, ValueFromPipeline )]
        [PsObject] $DataJourney,

        # The path of the export file, that should be created.
        [Parameter( Mandatory )]
        [System.IO.FileInfo] $Path
    )

    process {
        $DataJourney | ConvertTo-Yaml | Out-File $Path
    }
}