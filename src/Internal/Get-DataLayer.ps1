function Get-DataLayer {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [PSCustomObject] $InputObject,

        # If specified, only return data layer containing the provided models
        [Parameter()]
        [string[]] $Model,

        # If specified, only return data layer containing the provided flows
        [Parameter()]
        [string[]] $Flow,

        # If specified, only return data layer matching the provided layer
        [Parameter()]
        [string[]] $Layer,

        # If specified, scan the layers recursively.
        [Parameter()]
        [switch] $Recurse,

        # If specified, return all parent layers of filtered layers.
        [Parameter()]
        [switch] $Transitive
    )

    process {

        $filteredLayer = $InputObject |
            Where-Object { ( -not $Model ) -or ( $_.Models | Select-Object -ExpandProperty Key | Where-Object { $Model -contains $_ } ) } |
            Where-Object { ( -not $Flow ) -or ( $_.Flows | Select-Object -ExpandProperty Key | Where-Object { $Flow -contains $_ } ) }
        if ( $Layer -contains $InputObject.Key ) {
            $filteredLayer = $InputObject
        }

        if ( $filteredLayer ) {
            Write-Output $filteredLayer
        }

        if ( $Recurse.IsPresent ) {
            $InputObject.Layer |
            Where-Object { $_ } |
            Get-DataLayer -Model:$Model -Flow:$Flow -Recurse
        }

        if ( $Transitive.IsPresent ) {
            $children = $InputObject.Layer |
            Where-Object { $_ } |
            Get-DataLayer -Layer:$Layer -Transitive
            if ( $children ) {
                Write-Output $InputObject
                Write-Output $children
            }
        }

    }
}