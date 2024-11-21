function Export-DataLayer {

    [CmdletBinding()]
    param (
        # The path of the directory, where that export files should be created.
        [Parameter( Mandatory )]
        [ValidateScript({ $_.Exists })]
        [System.IO.DirectoryInfo] $ParentDirectory,

        # The key of the data layer that should be exported.
        [Parameter( Mandatory, ValueFromPipelineByPropertyName )]
        [ValidateSet( 'journey', 'layer' )]
        [string] $LayerType,

        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject] $InputObject
    )

    process {
        [System.IO.DirectoryInfo] $Directory = switch ( $LayerType ) {
            journey { $ParentDirectory }
            layer {
                if ( -not $InputObject.Key ) {
                    Write-Error 'Input lacks key property.'
                }
                Join-Path $ParentDirectory $InputObject.Key
            }
            Default {
                Write-Error "Unsupported LayerType '$_'"
            }
        }

        if ( -not $Directory.Exists ) {
            $Directory.Create()
        }

        if ( $InputObject.Models ) {
            [System.IO.DirectoryInfo] $ModelDirectory = Join-Path $Directory model
            if ( -not $ModelDirectory.Exists ) {
                $ModelDirectory.Create()
            }
            $InputObject.Models | Export-DataModel -ParentDirectory $ModelDirectory
        }

        if ( $InputObject.Layer ) {
            [System.IO.DirectoryInfo] $LayerDirectory = Join-Path $Directory layer
            if ( -not $LayerDirectory.Exists ) {
                $LayerDirectory.Create()
            }
            $InputObject.Layer | Export-DataLayer -ParentDirectory $LayerDirectory -LayerType layer
        }

        if ( $InputObject.Flows ) {
            [System.IO.DirectoryInfo] $FlowsDirectory = Join-Path $Directory flows
            if ( -not $FlowsDirectory.Exists ) {
                $FlowsDirectory.Create()
            }
            $InputObject.Flows | Export-DataFlow -ParentDirectory $FlowsDirectory
        }

        $Header = @{}

        if ( $InputObject.Title ) {
            $Header.Title = $InputObject.Title
        }

        if ( $Header ) {
            $Header | ConvertTo-Yaml | Out-File "$Directory/$LayerType.yml"
        }
    }
}