function New-DataModel {    
    
    [CmdletBinding()]
    param (
        # The identifier key of the data model.
        [Parameter(Position = 0)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ $_ -notmatch ' ' }, ErrorMessage = 'Value must not contain spaces.')]
        [string] $Key,
        
        # The title of the data model.
        [Parameter(Mandatory, Position = 0, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string] $Title,

        # The class of the data model.
        [Parameter(Position = 1, ValueFromPipelineByPropertyName)]
        [ValidateSet('', 'original', 'exchange', 'exchange-original', 'analysis', 'analysis-original', 'retention', 'retention-original')]
        [string] $Class
    )

    process {
        $model = [PSCustomObject]@{}

        if ( $Key ) {
            $model | Add-Member Key $Key
        }

        if ( $Title ) {
            $model | Add-Member Title $Title
        }

        if ( $Class ) {
            $model | Add-Member Class $Class
        }
        Write-Output $model
    }
}