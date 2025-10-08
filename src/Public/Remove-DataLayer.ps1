function Remove-DataLayer {

    <#

    .SYNOPSIS
    Removes an existing data layer from a data journey.

    .DESCRIPTION
    Removes an existing data layer from a data journey or data layer.

    #>

    [CmdletBinding()]
    param (
        # The data journey or parent layer, the layer is removed from.
        [Parameter(ValueFromPipeline, Mandatory)]
        [ValidateNotNull()]
        [Alias('Journey')]
        $Parent,

        # The identifier key of the layer.
        [Parameter(Mandatory, Position = 0, ParameterSetName = 'Properties')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ $_ -notmatch ' ' }, ErrorMessage = 'Value must not contain spaces.')]
        [string[]] $Key,

        # Remove the layer if found in sub-layers recursively if found.
        [Parameter()]
        [switch] $Recurse
    )

    process {
        $Parent.Layer = $Parent.Layer | Where-Object Key -NotIn $Key
        if ( $Recurse.IsPresent -and $Parent.Layer ) {
            $Parent.Layer | ForEach-Object {
                $_ | Remove-DataLayer -Key:$Key -Recurse:$Recurse
            }
        }
    }
}