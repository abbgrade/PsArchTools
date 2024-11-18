function Add-DataLayer {

    <#
    
    .SYNOPSIS
    Adds a new data layer to a data journey.

    .DESCRIPTION
    Creates and adds a data layer to a data journey or data layer.

    #>
    
    [CmdletBinding()]
    param (
        # The data journey or parent layer, the layer is added to.
        [Parameter(ValueFromPipeline, Mandatory)]
        [ValidateNotNull()]
        [Alias('Journey')]
        $Parent,

        # The identifier key of the layer.
        [Parameter(Mandatory, Position = 0, ParameterSetName = 'Properties')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ $_ -notmatch ' ' }, ErrorMessage = 'Value must not contain spaces.')]
        [string] $Key,

        # The title of the layer.
        [Parameter(Position = 1, ParameterSetName = 'Properties')]
        [string] $Title,

        # The data layer is added to the data journey.
        [Parameter( Mandatory, ParameterSetName = 'InputObject' )]
        [PSCustomObject] $InputObject,

        # Switch that specifies, if the layer should be returned instead of only added to the data journey.
        [Parameter()]
        [switch] $PassThru
    )

    process {
        switch ($PsCmdlet.ParameterSetName) {
            Properties {
                $InputObject = New-DataLayer -Key:$Key -Title:$Title
            }
            InputObject {
            }
            default {
                Write-Error "ParameterSetName '$_' not supported"
            }
        }

        $Parent.Layer += $InputObject

        if ( $PassThru.IsPresent ) {
            Write-Output $InputObject
        }
    }
}