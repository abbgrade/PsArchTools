function New-Roadmap {

    [CmdletBinding()]
    param (
        [Parameter( Mandatory )]
        [ValidateNotNullOrEmpty()]
        [string] $Title
    )

    process {
        [PSCustomObject]@{
            Title      = $Title
            Features   = @()
            Milestones = @()
        }
    }

}