function Export-DataModel {

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
        $model = ([PSCustomObject]$InputObject) | New-DataModel
        $key = $model.Key
        $model | Select-Object -ExcludeProperty Key | ConvertTo-Yaml | Out-File -Path ( Join-Path $ParentDirectory "$key.yml" )
    }

}