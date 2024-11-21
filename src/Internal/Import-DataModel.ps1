function Import-DataModel {

    [CmdletBinding()]
    param (
        # The path of the export file, that should be imported.
        [Parameter( Mandatory )]
        [ValidateScript({ $_.Exists })]
        [System.IO.FileInfo] $Path
    )

    process {
        $header = Get-Content -Path $Path -Raw | ConvertFrom-Yaml
        $header.Key = $Path.BaseName
        $model = New-DataModel @header
        Write-Output $model
    }

}