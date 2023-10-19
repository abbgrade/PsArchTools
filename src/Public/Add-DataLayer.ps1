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
        $Parent,

        # The identifier key of the layer.
        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ $_ -notmatch ' ' }, ErrorMessage = 'Value must not contain spaces.')]
        [string] $Key,

        # The title of the layer.
        [Parameter(Position = 1)]
        [ValidateNotNullOrEmpty()]
        [string] $Title,

        # Switch that specifies, if the layer should be returned instead of only added to the data journey.
        [Parameter()]
        [switch] $PassThru
    )

    process {
        $layer = [PSCustomObject]@{
            Key  = $Key
            Layer  = @()
            Models = @()
            Flows = @()
        }

        if ( $Title ) {
            $layer | Add-Member Title $Title
        }

        $Parent.Layer += $layer

        if ( $PassThru.IsPresent ) {
            Write-Output $layer
        }
    }
}