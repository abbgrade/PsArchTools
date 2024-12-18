function Import-DataLayer {

    [CmdletBinding()]
    param (
        # The path of the export directory, that should be imported.
        [Parameter( Mandatory )]
        [ValidateScript({ $_.Exists })]
        [System.IO.DirectoryInfo] $Directory
    )

    process {
        $header = Get-Content -Path ( Join-Path $Directory 'layer.yml' ) -Raw | ConvertFrom-Yaml
        $header.Key = $Directory.Name
        $layer = New-DataLayer @header

        [System.IO.DirectoryInfo] $ModelDirectory = Join-Path $Directory model
        if ( $ModelDirectory.Exists ) {
            Get-ChildItem $ModelDirectory | ForEach-Object {
                $model = Import-DataModel -Path $_
                $layer | Add-DataModel -InputObject $model
            }
        }

        [System.IO.DirectoryInfo] $LayerDirectory = Join-Path $Directory layer
        if ( $LayerDirectory.Exists ) {
            Get-ChildItem $LayerDirectory | ForEach-Object {
                $sublayer = Import-DataLayer -Directory $_
                $layer | Add-DataLayer -InputObject $sublayer
            }
        }

        [System.IO.DirectoryInfo] $FlowDirectory = Join-Path $Directory flows
        if ( $FlowDirectory.Exists ) {
            Get-ChildItem $FlowDirectory | ForEach-Object {
                $flow = Import-DataFlow -Path $_
                $layer | Add-DataFlow -InputObject $flow
            }
        }

        Write-Output $layer
    }

}