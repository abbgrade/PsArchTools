function Select-DataJourney {

    <#

    .SYNOPSIS
    Select from a data journey.

    .DESCRIPTION
    Return a copy of a data journey and apply filter on it.

    #>

    [CmdletBinding()]
    param (
        # Data journey to select from.
        [Parameter(Mandatory, ValueFromPipeline)]
        [PSCustomObject] $Journey,

        # Models in the data journey diagram.
        [Parameter()]
        [string[]] $Model,

        # Flows in the data journey diagram.
        [Parameter()]
        [string[]] $Flow,

        # Layer in the data journey diagram.
        [Parameter()]
        [string] $Layer
    )

    process {

        $flowFilter = $Flow

        # select all flows specified
        $selectedFlows = $Journey | Get-DataFlow -Key $flowFilter -Recurse

        # select models used by selected flows
        $transitiveModels = $selectedFlows | ForEach-Object {
            $_.Sources | ForEach-Object { $_ }
            $_.Sinks | ForEach-Object { $_ }
        }

        # union all required models
        [string[]] $modelFilter = ( $transitiveModels + $Model) | Where-Object { $_ } | Select-Object -Unique

        # select all layers used by required models
        $transitiveLayersByModels = $Journey | Get-DataLayer -Model $modelFilter -Recurse

        # select all layers used by required flows
        $transitiveLayersByFlows = $Journey | Get-DataLayer -Flow $flowFilter -Recurse

        # select layers required by flows or models (recursively)
        $transitiveLayers = $Journey | Get-DataLayer -Layer ( ( $transitiveLayersByModels + $transitiveLayersByFlows ) | Where-Object { $_ } ) -Transitive
        [string[]] $layerFilter = ( ( $transitiveLayers | Where-Object { $_.Key } | Select-Object -ExpandProperty Key ) + $Layer) | Where-Object { $_ } | Select-Object -Unique

        # filter layer
        $selectedJourney = New-DataJourney -Title:$Journey.Title
        $Journey | Select-DataJourneyLayer `
            -Target $selectedJourney `
            -Flow:$flowFilter `
            -Model:$modelFilter `
            -Layer:$layerFilter

        # return output
        $selectedJourney | Write-Output
    }
}