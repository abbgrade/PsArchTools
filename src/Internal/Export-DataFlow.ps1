function Export-DataFlow {
    
    [CmdletBinding()]
    param (
        # The path of the directory, where that export files should be created.
        [Parameter( Mandatory )]
        [ValidateScript({ $_.Exists })]
        [System.IO.DirectoryInfo] $ParentDirectory,

        # The identifier key of the data flow.
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ $_ -notmatch ' ' }, ErrorMessage = 'Value must not contain spaces.')]
        [string] $Key,

        # The title of the data flow.
        [Parameter(Position = 1, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string] $Title,

        # The source models of tha data flow
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string[]] $Sources,

        # The sink models of tha data flow
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string[]] $Sinks
    )

    process {
        $flow = New-DataFlow -Title:$Title -Source:$Sources -Sink:$Sinks
        $flow | ConvertTo-Yaml | Out-File -Path ( Join-Path $ParentDirectory "$Key.yml" )
    }

}