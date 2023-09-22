function Add-DataFlow {

    <#
    
    .SYNOPSIS
    Adds a new data flow to a data journey.

    .DESCRIPTION
    Creates and adds a data flow to a data journey. 
    If the source or the sink models are not defined, they will be created implicitly.

    #>
    
    [CmdletBinding()]
    param (
        # The data journey, the data flow is added to.
        [Parameter(ValueFromPipeline, Mandatory)]
        [ValidateNotNull()]
        $Journey,

        # The title of the data flow.
        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string] $Title,

        # The source models of tha data flow
        [Parameter(ValueFromPipeline, Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string[]] $Source,

        # The sink models of tha data flow
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