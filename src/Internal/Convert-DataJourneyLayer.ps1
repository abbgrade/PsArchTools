function Convert-DataJourneyLayer {
    
    [CmdletBinding()]
    param (
        [Parameter( Mandatory )]
        $Parent,
        
        [Parameter()]
        [ValidateNotNull()]
        [PSCustomObject[]] $Layer,
        
        [Parameter()]
        [ValidateNotNull()]
        [PSCustomObject[]] $Models,
        
        [Parameter()]
        [ValidateNotNull()]
        [PSCustomObject[]] $Flows
    )

    process {
        $Models | ForEach-Object {
            $Parent | Add-MermaidFlowchartNode $_.Title -Shape cylindrical -Class:$_.Class
        }

        $Flows | ForEach-Object {
            $flow = $_
            $flowId = $_.Title
            $Parent | Add-MermaidFlowchartNode $flowId -Shape rhombus
            $flow.Sources | ForEach-Object {
                $Parent | Add-MermaidFlowchartLink -Source $_ -Destination $flowId
            }
            $flow.Sinks | ForEach-Object {
                $Parent | Add-MermaidFlowchartLink -Source $flowId -Destination $_
            }
        }

        $Layer | ForEach-Object {
            $subgraph = $Parent | Add-MermaidFlowchartSubgraph -Key $_.Title -PassThru
            Convert-DataJourneyLayer `
                -Parent $subgraph `
                -Models ( $_.Models ? $_.Models : @() ) `
                -Flows ( $_.Flows ? $_.Flows : @() ) `
                -Layer ( $_.Layer ? $_.Layer : @() )
        }

    }
}