function Export-DataFlow {

    [CmdletBinding()]
    param (
        # The path of the directory, where that export files should be created.
        [Parameter( Mandatory )]
        [ValidateScript({ $_.Exists })]
        [System.IO.DirectoryInfo] $ParentDirectory,

        [Parameter(Mandatory, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [PSCustomObject] $InputObject
    )

    process {
        $flow = ([PSCustomObject] $InputObject) | New-DataFlow
        $key = $flow.Key
        $flow | Select-Object -ExcludeProperty Key | ConvertTo-Yaml | Out-File -Path ( Join-Path $ParentDirectory "$key.yml" )
    }

}