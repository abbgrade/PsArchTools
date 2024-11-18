function Export-DataLayer {

    [CmdletBinding()]
    param (
        # The path of the directory, where that export files should be created.
        [Parameter( Mandatory )]
        [ValidateScript({ $_.Exists })]
        [System.IO.DirectoryInfo] $ParentDirectory,

        # The key of the data layer that should be exported.
        [Parameter( ValueFromPipelineByPropertyName )]
        [ValidateNotNullOrEmpty()]
        [string] $Key,

        # The key of the data layer that should be exported.
        [Parameter( Mandatory, ValueFromPipelineByPropertyName )]
        [ValidateSet( 'journey', 'layer' )]
        [string] $LayerType,

        # The title of the data layer that should be exported.
        [Parameter( Mandatory, ValueFromPipelineByPropertyName )]
        [string] $Title,

        # The models of the data layer that should be exported.
        [Parameter( ValueFromPipelineByPropertyName )]
        [PsObject[]] $Models,

        # The sub layer of the data layer that should be exported.
        [Parameter( ValueFromPipelineByPropertyName )]
        [PsObject[]] $Layer,

        # The flows of data layer that should be exported.
        [Parameter( ValueFromPipelineByPropertyName )]
        [PsObject[]] $Flows
    )

    process {
        [System.IO.DirectoryInfo] $Directory = switch ( $LayerType ) {
            journey { $ParentDirectory }
            layer { Join-Path $ParentDirectory $Key }
            Default {
                Write-Error "Unsupported LayerType '$_'"
            }
        }

        if ( -not $Directory.Exists ) {
            $Directory.Create()
        }

        if ( $Models ) {
            [System.IO.DirectoryInfo] $ModelDirectory = Join-Path $Directory model
            if ( -not $ModelDirectory.Exists ) {
                $ModelDirectory.Create()
            }
            $Models | Export-DataModel -ParentDirectory $ModelDirectory
        }

        if ( $Layer ) {
            [System.IO.DirectoryInfo] $LayerDirectory = Join-Path $Directory layer
            if ( -not $LayerDirectory.Exists ) {
                $LayerDirectory.Create()
            }
            $Layer | Export-DataLayer -ParentDirectory $LayerDirectory -LayerType layer
        }

        if ( $Flows ) {
            [System.IO.DirectoryInfo] $FlowsDirectory = Join-Path $Directory flows
            if ( -not $FlowsDirectory.Exists ) {
                $FlowsDirectory.Create()
            }
            $Flows | Export-DataFlow -ParentDirectory $FlowsDirectory
        }

        $Header = @{}

        if ( $Title ) {
            $Header.Title = $Title
        }

        if ( $Header ) {
            $Header | ConvertTo-Yaml | Out-File "$Directory/$LayerType.yml"
        }
    }
}