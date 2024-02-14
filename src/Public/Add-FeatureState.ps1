function Add-FeatureState {

    <#
    
    .SYNOPSIS
    Adds a new feature state difinition to a roadmap.

    .DESCRIPTION
    Creates and adds a feature state to a previously created roadmap object.
    It is used to customize the style in the diagram.

    .EXAMPLE
    PS> $Roadmap = New-ArchRoadmap -Title MyRoadmap
    PS> $Roadmap | Add-ArchFeatureState -State Done -Style 'fill:#86c787'
    
    Fill the feature in state Done in color #86c787.

    #>

    [CmdletBinding()]
    param (
        # The roadmap, the feature state is added to.
        [Parameter(ValueFromPipeline, Mandatory)]
        [ValidateNotNull()]
        $Roadmap,
        
        # Mermaid style string.
        [Parameter( Mandatory )]
        [string]
        $Style,
        
        # Name of the feature state.
        [Parameter()]
        [string]
        $State
    )

    process {
        $Roadmap.FeatureStates[$State] = $Style
    }
}