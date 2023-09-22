function ConvertTo-Diagram {

    <#
    
    .SYNOPSIS
    Converts the roadmap to diagram.

    .DESCRIPTION
    Creates a mermaid flowchart to display the roadmap.

    .EXAMPLE
    PS> $Roadmap = New-ArchRoadmap 'Diagram Title'
    PS> $Roadmap | Add-ArchFeature A 'do this' -Link 'https://www.github.com'
    PS> $Roadmap | Add-ArchFeature B 'do that' -Link 'https://www.github.com'
    PS> $Roadmap | Add-ArchMilestone C 'be epic' -DependsOn A, B
    PS> $Roadmap | Add-ArchFeature D 'do whatever' -DependsOn C
    PS> $Roadmap | Add-ArchFeature E 'do what else' -DependsOn C
    PS> $Roadmap | ConvertTo-ArchDiagram
    ---
    title: Diagram Title
    ---
    flowchart
        classDef feature fill:#ffcc5c
        classDef milestone fill:#96ceb4
        A[do this]:::feature
        B[do that]:::feature
        D[do whatever]:::feature
        E[do what else]:::feature
        C[be epic]:::milestone
        click A "https://www.github.com" _blank
        click B "https://www.github.com" _blank
        C --> D
        C --> E
        A --> C
        B --> C
    #>

    [CmdletBinding()]
    param (
        # Title of the roadmap diagram.
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'roadmap')]
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'journey')]
        [string] $Title,
        
        # Features in the roadmap diagram.
        [Parameter(ValueFromPipelineByPropertyName, ParameterSetName = 'roadmap')]
        [ValidateNotNull()]
        [PSCustomObject[]] $Features,
        
        # Milestones in the roadmap diagram.
        [Parameter(ValueFromPipelineByPropertyName, ParameterSetName = 'roadmap')]
        [ValidateNotNull()]
        [PSCustomObject[]] $Milestones,
        
        # Models in the data journey diagram.
        [Parameter(ValueFromPipelineByPropertyName, ParameterSetName = 'journey')]
        [ValidateNotNull()]
        [PSCustomObject[]] $Models,
        
        # Flows in the data journey diagram.
        [Parameter(ValueFromPipelineByPropertyName, ParameterSetName = 'journey')]
        [ValidateNotNull()]
        [PSCustomObject[]] $Flows,
        
        # Layer in the data journey diagram.
        [Parameter(ValueFromPipelineByPropertyName, ParameterSetName = 'journey')]
        [ValidateNotNull()]
        [PSCustomObject[]] $Layer
    )

    process {
        switch ($PSCmdlet.ParameterSetName) {
            roadmap {
                $diagram = New-MermaidDiagram -Flowchart -Title $Title -Orientation left-to-right
                $diagram | Add-MermaidFlowchartClass -Name feature -Style 'fill:#ffcc5c'
                $diagram | Add-MermaidFlowchartClass -Name milestone -Style 'fill:#96ceb4'

                $Features | ForEach-Object {
                    $node = [PSCustomObject] $_
                    $diagram | Add-MermaidFlowchartNode `
                        -Key $node.Id `
                        -Name ('"' + $node.Title + '"') `
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
                        -Name ('"' + $node.Title + '"') `
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
            journey {
                $diagram = New-MermaidDiagram -Flowchart -Title $Title -Orientation top-down

                $diagram | Add-MermaidFlowchartClass -Name original -Style 'fill:#ffffff,stroke:#555555,stroke-width:4px'
                $diagram | Add-MermaidFlowchartClass -Name exchange -Style 'fill:#ffe6cc,stroke:#d79b00'
                $diagram | Add-MermaidFlowchartClass -Name exchange-original -Style 'fill:#ffe6cc,stroke:#d79b00,stroke-width:4px'
                $diagram | Add-MermaidFlowchartClass -Name analysis -Style 'fill:#e1d5e7,stroke:#9673a6'
                $diagram | Add-MermaidFlowchartClass -Name analysis-original -Style 'fill:#e1d5e7,stroke:#9673a6,stroke-width:4px'
                $diagram | Add-MermaidFlowchartClass -Name retention -Style 'fill:#d5e8d4,stroke:#82b366'
                $diagram | Add-MermaidFlowchartClass -Name retention-original -Style 'fill:#d5e8d4,stroke:#82b366,stroke-width:4px'

                Convert-DataJourneyLayer -Parent $diagram -Models $Models -Flows $Flows -Layer $Layer
                $diagram | ConvertTo-MermaidString | Write-Output
            }
            Default {
                Write-Error "convert $_ is not supported."
            }
        }
    }
}

