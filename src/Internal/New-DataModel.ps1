function New-DataModel {

    [CmdletBinding()]
    param (
        # The identifier key of the data model.
        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ $_ -notmatch ' ' }, ErrorMessage = 'Value must not contain spaces.')]
        [string] $Key = $_.Title,

        # The title of the data model.
        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string] $Title = $_.Key,

        # The description of the data model.
        [Parameter(ValueFromPipelineByPropertyName)]
        [string] $Description,

        # The class of the data model.
        [Parameter(ValueFromPipelineByPropertyName)]
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

        if ( $Description )
        {
            $model | Add-Member Description $Description
        }

        if ( $Class ) {
            $model | Add-Member Class $Class
        }
        Write-Output $model
    }
}