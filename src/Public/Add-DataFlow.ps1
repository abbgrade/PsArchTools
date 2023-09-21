function Add-DataFlow {
    
    [CmdletBinding()]
    param (
        # The journey, the flow is added to.
        [Parameter(ValueFromPipeline, Mandatory)]
        [ValidateNotNull()]
        $Journey,

        # The title of the flow.
        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string] $Title,

        [Parameter(ValueFromPipeline, Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string[]] $Source,

        [Parameter(ValueFromPipeline, Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string[]] $Sink
    )

    process {
        $flow = [PSCustomObject]@{
            Title = $Title
            Sources = $Source
            Sinks = $Sink
        }

        $Journey.Flows += $flow

        if ( $PassThru.IsPresent ) {
            Write-Output $flow
        }
    }
}