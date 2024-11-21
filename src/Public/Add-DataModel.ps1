function Add-DataModel {

    <#

    .SYNOPSIS
    Adds a new data model to a data journey.

    .DESCRIPTION
    Creates and adds a data model to a data journey.

    #>

    [CmdletBinding()]
    param (
        # The data journey or layer, the data model is added to.
        [Parameter(ValueFromPipeline, Mandatory)]
        [ValidateNotNull()]
        [Alias('Journey')]
        $Parent,

        # The identifier key of the data model.
        [Parameter(ParameterSetName = 'Properties' )]
        [ValidateScript({ $_ -notmatch ' ' }, ErrorMessage = 'Value must not contain spaces.')]
        [string] $Key,

        # The title of the data model.
        [Parameter(Mandatory, Position = 0, ParameterSetName = 'Properties')]
        [ValidateNotNullOrEmpty()]
        [string] $Title,

        # The class of the data model.
        [Parameter(Position = 1, ParameterSetName = 'Properties')]
        [ValidateNotNullOrEmpty()]
        [ValidateSet('original', 'exchange', 'exchange-original', 'analysis', 'analysis-original', 'retention', 'retention-original')]
        [string] $Class,

        # The data model is added to the data journey.
        [Parameter( Mandatory, ParameterSetName = 'InputObject' )]
        [PSCustomObject] $InputObject,

        # Switch that specifies, if the model should be returned instead of only added to the data journey.
        [Parameter()]
        [switch] $PassThru
    )

    process {
        switch ($PsCmdlet.ParameterSetName) {
            Properties {
                if ( -not $Key) {
                    $Key = $Title
                }
                $InputObject = New-DataModel -Key:$Key -Title:$Title -Class:$Class
            }
            InputObject {
            }
            default {
                Write-Error "ParameterSetName '$_' not supported"
            }
        }

        $Parent.Models += $InputObject

        if ( $PassThru.IsPresent ) {
            Write-Output $InputObject
        }
    }
}