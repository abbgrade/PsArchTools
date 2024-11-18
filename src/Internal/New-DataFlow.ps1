function New-DataFlow {

    [CmdletBinding()]
    param (
        # The identifier key of the data flow.
        [Parameter(ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ $_ -notmatch ' ' }, ErrorMessage = 'Value must not contain spaces.')]
        [string] $Key,

        # The title of the data flow.
        [Parameter(ValueFromPipelineByPropertyName)]
        [string] $Title,

        # The source models of tha data flow
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string[]] $Sources,

        # The sink models of tha data flow
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [ValidateNotNullOrEmpty()]
        [string[]] $Sinks
    )

    process {
        $flow = [PSCustomObject]@{
            Sources = $Sources
            Sinks   = $Sinks
        }

        if ( $Key ) {
            $flow | Add-Member Key $Key
        }

        if ( $Title ) {
            $flow | Add-Member Title $Title
        }

        Write-Output $flow
    }
}