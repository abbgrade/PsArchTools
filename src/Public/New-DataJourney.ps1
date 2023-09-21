function New-DataJourney {

    [CmdletBinding()]
    [OutputType('DataJourney')]
    param (
        # Specifies the title.
        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [string] $Title
    )

    process {
        [PSCustomObject]@{
            Title = $Title
            Layer = @()
            Models = @()
            Flows = @()
        }
    }

}