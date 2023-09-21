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
            $Parent | Add-MermaidFlowchartNode $_.Title
        }

        $Flows | ForEach-Object {
            $flow = $_
            $flow.Sources | ForEach-Object {
                $source = $_
                $flow.Sinks | ForEach-Object {
                    $sink = $_
                    $Parent | Add-MermaidFlowchartLink -Source $source -Destination $sink
                }
            }
        }

        $Layer | ForEach-Object {
            $subgraph = $Parent | Add-MermaidFlowchartSubgraph -Key $_.Title -PassThru
            Convert-DataJourneyLayer -Parent $subgraph -Models $_.Models -Flows $_.Flows -Layer $_.Layer
        }

    }
}