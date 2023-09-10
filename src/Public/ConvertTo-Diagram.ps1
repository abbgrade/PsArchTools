function ConvertTo-Diagram {

    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipelineByPropertyName)]
        [string]
        $Title,
        
        [Parameter(ValueFromPipelineByPropertyName)]
        [PSCustomObject[]]
        $Features,
        
        [Parameter(ValueFromPipelineByPropertyName)]
        [PSCustomObject[]]
        $Milestones
    )

    $diagram = New-MermaidDiagram -Flowchart -Title $Title
    $diagram | Add-MermaidFlowchartClass -Name feature -Style 'fill:#ffcc5c'
    $diagram | Add-MermaidFlowchartClass -Name milestone -Style 'fill:#96ceb4'

    $Features | ForEach-Object {
        $node = [PSCustomObject] $_
        $diagram | Add-MermaidFlowchartNode `
            -Key $node.Id `
            -Name $node.Title `
            -Class feature
        
            if ( $node.Link ) {
            $diagram | Add-MermaidFlowchartClick `
                -Node $node.Id `
                -Url $node.Link `
                -Target blank
        }

        if ( $node.Dependencies ) {
            $node.Dependencies | ForEach-Object {
                $diagram | Add-MermaidFlowchartLink `
                    -Source $_ `
                    -Destination $node.Id
            }
        }
    }

    $Milestones | ForEach-Object {
        $node = [PSCustomObject] $_
        $diagram | Add-MermaidFlowchartNode `
            -Key $node.Id `
            -Name $node.Title `
            -Class milestone

        if ( $node.Dependencies ) {
            $node.Dependencies | ForEach-Object {
                $diagram | Add-MermaidFlowchartLink `
                    -Source $_ `
                    -Destination $node.Id
            }
        }
    }

    $diagram | ConvertTo-MermaidString | Write-Output
}
