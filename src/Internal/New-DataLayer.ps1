function New-DataLayer {

    [CmdletBinding()]
    param (
        # The identifier key of the data layer.
        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ $_ -notmatch ' ' }, ErrorMessage = 'Value must not contain spaces.')]
        [string] $Key,

        # The title of the data layer.
        [Parameter(ValueFromPipelineByPropertyName)]
        [string] $Title
    )

    process {
        $layer = [PSCustomObject]@{}

        if ( $Key ) {
            $layer | Add-Member Key $Key
        }

        if ( $Title ) {
            $layer | Add-Member Title $Title
        }

        $layer | Add-Member Layer @()
        $layer | Add-Member Models @()
        $layer | Add-Member Flows @()

        Write-Output $layer
    }
}