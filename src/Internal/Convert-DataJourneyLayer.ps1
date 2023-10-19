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
        [PSCustomObject[]] $Flows,
        
        [Parameter()]
        [int] $Depth
    )

    process {
        $Models | ForEach-Object {
            $Parent | Add-MermaidFlowchartNode -Key $_.Title -Shape cylindrical -Class:$_.Class
        }

        $Flows | ForEach-Object {
            $flow = $_
            $flowId = $_.Key
            
            $flowParameter = @{
                Key = $flowId
            }

            if ( $_.Title ) {
                $flowParameter.Text = $_.Title
            }

            $Parent | Add-MermaidFlowchartNode @flowParameter -Shape rhombus
            $flow.Sources | ForEach-Object {
                $Parent | Add-MermaidFlowchartLink -Source $_ -Destination $flowId
            }
            $flow.Sinks | ForEach-Object {
                $Parent | Add-MermaidFlowchartLink -Source $flowId -Destination $_
            }
        }

        $Layer | ForEach-Object {
            $subgraphParameter = @{}

            if ( $_.Title ) {
                $subgraphParameter.Title = $_.Title
            }

            $subgraph = $Parent | Add-MermaidFlowchartSubgraph -Key $_.Key -PassThru @subgraphParameter
            Convert-DataJourneyLayer `
                -Parent $subgraph `
                -Models ( $_.Models ? $_.Models : @() ) `
                -Flows ( $_.Flows ? $_.Flows : @() ) `
                -Layer ( $_.Layer ? $_.Layer : @() ) `
                -Depth ( $Depth + 1 )

            $Parent | Add-MermaidFlowchartNode -Key $_.Key -Class "layer-$Depth"
        }

    }
}