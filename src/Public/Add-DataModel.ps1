function Add-DataModel {
    
    [CmdletBinding()]
    param (
        # The journey, the model is added to.
        [Parameter(ValueFromPipeline, Mandatory)]
        [ValidateNotNull()]
        $Journey,

        # The title of the model.
        [Parameter(Mandatory, Position=1)]
        [ValidateNotNullOrEmpty()]
        [string] $Title,

        # Switch that specifies, if the model should be returned instead of only added to the journey.
        [Parameter()]
        [switch] $PassThru
    )

    process {
        $model = [PSCustomObject]@{
            Title = $Title
        }

        $Journey.Models += $model

        if ( $PassThru.IsPresent ) {
            Write-Output $model
        }
    }
}