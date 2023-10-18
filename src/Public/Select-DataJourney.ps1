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

        # filter data flows
        $selectedFlowsJourney = New-DataJourney -Title:$Journey.Title
        $Journey | Select-DataJourneyLayer `
            -Target $selectedFlowsJourney `
            -Flow:$Flow

        # prepare model filter
        $transitiveModels = $selectedFlowsJourney | 
            Get-DataFlow -Recurse | 
            ForEach-Object {
                $_.Sources | ForEach-Object { $_ }
                $_.Sinks | ForEach-Object { $_ }
            }
        [string[]] $modelFilter = ( $transitiveModels + $Model) | Where-Object { $_ }
        
        # filter models
        $selectedModelsJourney = New-DataJourney -Title:$Journey.Title
        $selectedFlowsJourney | Select-DataJourneyLayer `
            -Target $selectedModelsJourney `
            -Model:$modelFilter
        
        # prepare layer filter
        $transitiveLayer = $selectedModelsJourney | 
            Get-DataLayer -Recurse | 
            Where-Object {
                $_.Layer -or $_.Models
            } | Where-Object Key | Select-Object -ExpandProperty Key
        [string[]] $layerFilter = ( $transitiveLayer + $Layer) | Where-Object { $_ }

        # filter layer
        $selectedLayerJourney = New-DataJourney -Title:$Journey.Title
        $selectedModelsJourney | Select-DataJourneyLayer `
            -Target $selectedLayerJourney `
            -Model:$modelFilter `
            -Layer:$layerFilter

        # return output
        $selectedLayerJourney | Write-Output
    }
}