function Add-DataFlow {
    
    [CmdletBinding()]
    param (
        # The journey, the flow is added to.
        [Parameter(ValueFromPipeline, Mandatory)]
        [ValidateNotNull()]
        $Journey,

        [Parameter(ValueFromPipeline, Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string[]] $Source,

        [Parameter(ValueFromPipeline, Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string[]] $Sink
    )

    process {
        $flow = [PSCustomObject]@{
            Sources = $Source
            Sinks = $Sink
        }

        $Journey.Flows += $flow

        if ( $PassThru.IsPresent ) {
            Write-Output $flow
        }
    }
}