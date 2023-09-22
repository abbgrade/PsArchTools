function Add-DataModel {

    <#
    
    .SYNOPSIS
    Adds a new data model to a data journey.

    .DESCRIPTION
    Creates and adds a data model to a data journey.

    #>
    
    [CmdletBinding()]
    param (
        # The data journey, the data model is added to.
        [Parameter(ValueFromPipeline, Mandatory)]
        [ValidateNotNull()]
        $Journey,

        # The title of the data model.
        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string] $Title,

        # The class of the data model.
        [Parameter(Position = 1)]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('original', 'exchange', 'exchange-original', 'analysis', 'analysis-original', 'retention', 'retention-original')]
        [string] $Class,

        # Switch that specifies, if the model should be returned instead of only added to the data journey.
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