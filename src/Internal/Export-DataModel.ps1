function Export-DataModel {
    
    [CmdletBinding()]
    param (
        # The path of the directory, where that export files should be created.
        [Parameter( Mandatory )]
        [ValidateScript({ $_.Exists })]
        [System.IO.DirectoryInfo] $ParentDirectory,

        # The identifier key of the data model.
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ $_ -notmatch ' ' }, ErrorMessage = 'Value must not contain spaces.')]
        [string] $Key,

        # The title of the data model.
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string] $Title,

        # The class of the data model.
        [Parameter(Position = 1, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('original', 'exchange', 'exchange-original', 'analysis', 'analysis-original', 'retention', 'retention-original')]
        [string] $Class
    )

    process {
        $flow = New-DataModel -Title:$Title -Class:$Class
        $flow | ConvertTo-Yaml | Out-File -Path ( Join-Path $ParentDirectory "$Key.yml" )
    }
    
}