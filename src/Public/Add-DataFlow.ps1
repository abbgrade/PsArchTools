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

        # The identifier key of the data flow.
        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ $_ -notmatch ' ' }, ErrorMessage = 'Value must not contain spaces.')]
        [string] $Key,

        # The title of the data flow.
        [Parameter(Position = 1)]
        [ValidateNotNullOrEmpty()]
        [string] $Title,

        # The source models of tha data flow
        [Parameter(ValueFromPipeline, Mandatory)]
        [ValidateNotNullOrEmpty()]
        [Alias('Source')]
        [string[]] $Sources,

        # The sink models of tha data flow
        [Parameter(ValueFromPipeline, Mandatory)]
        [ValidateNotNullOrEmpty()]
        [Alias('Sink')]
        [string[]] $Sinks
    )

    process {
        $flow = New-DataFlow -Key:$Key -Title:$Title -Sources:$Sources -Sinks:$Sinks

        $Journey.Flows += $flow

        if ( $PassThru.IsPresent ) {
            Write-Output $flow
        }
    }
}