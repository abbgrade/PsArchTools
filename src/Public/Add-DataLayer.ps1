function Add-DataLayer {
    
    [CmdletBinding()]
    param (
        # The journey, the layer is added to.
        [Parameter(ValueFromPipeline, Mandatory)]
        [ValidateNotNull()]
        $Journey,

        # The title of the layer.
        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string] $Title,

        # Switch that specifies, if the layer should be returned instead of only added to the journey.
        [Parameter()]
        [switch] $PassThru
    )

    process {
        $layer = [PSCustomObject]@{
            Title  = $Title
            Layer  = @()
            Models = @()
            Flows = @()
        }

        $Journey.Layer += $layer

        if ( $PassThru.IsPresent ) {
            Write-Output $layer
        }
    }
}