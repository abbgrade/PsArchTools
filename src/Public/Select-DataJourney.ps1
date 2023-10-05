function Select-DataJourney {

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
        $selectedJourney = New-DataJourney -Title:$Journey.Title

        $Journey | Select-DataJourneyLayer `
            -Target $selectedJourney `
            -Model:$Model `
            -Flow:$Flow `
            -Layer:$Layer `

        $selectedJourney | Write-Output
    }
}