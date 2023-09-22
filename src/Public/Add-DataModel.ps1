function Add-DataModel {
    
    [CmdletBinding()]
    param (
        # The journey, the model is added to.
        [Parameter(ValueFromPipeline, Mandatory)]
        [ValidateNotNull()]
        $Journey,

        # The title of the model.
        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string] $Title,

        # The class of the model.
        [Parameter(Position = 1)]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('original', 'exchange', 'exchange-original', 'analysis', 'analysis-original', 'retention', 'retention-original')]
        [string] $Class,

        # Switch that specifies, if the model should be returned instead of only added to the journey.
        [Parameter()]
        [switch] $PassThru
    )

    process {
        $model = [PSCustomObject]@{
            Title = $Title
        }

        if ( $Class ) {
            $model | Add-Member Class $Class
        }

        $Journey.Models += $model

        if ( $PassThru.IsPresent ) {
            Write-Output $model
        }
    }
}