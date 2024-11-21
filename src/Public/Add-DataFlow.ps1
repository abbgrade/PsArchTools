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
        [Parameter(Mandatory, Position = 0, ParameterSetName = 'Properties')]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ $_ -notmatch ' ' }, ErrorMessage = 'Value must not contain spaces.')]
        [string] $Key,

        # The title of the data flow.
        [Parameter(Position = 1, ParameterSetName = 'Properties')]
        [ValidateNotNullOrEmpty()]
        [string] $Title,

        # The source models of tha data flow
        [Parameter(ValueFromPipeline, Mandatory, ParameterSetName = 'Properties')]
        [ValidateNotNullOrEmpty()]
        [Alias('Source')]
        [string[]] $Sources,

        # The sink models of tha data flow
        [Parameter(ValueFromPipeline, Mandatory, ParameterSetName = 'Properties')]
        [ValidateNotNullOrEmpty()]
        [Alias('Sink')]
        [string[]] $Sinks,

        # The data flow is added to the data journey.
        [Parameter( Mandatory, ParameterSetName = 'InputObject' )]
        [PSCustomObject] $InputObject,

        # Switch that specifies, if the model should be returned instead of only added to the data journey.
        [Parameter()]
        [switch] $PassThru
    )

    process {
        switch ($PsCmdlet.ParameterSetName) {
            Properties {
                $InputObject = New-DataFlow -Key:$Key -Title:$Title -Sources:$Sources -Sinks:$Sinks
            }
            InputObject {
            }
            default {
                Write-Error "ParameterSetName '$_' not supported"
            }
        }

        $Journey.Flows += $InputObject

        if ( $PassThru.IsPresent ) {
            Write-Output $InputObject
        }
    }
}