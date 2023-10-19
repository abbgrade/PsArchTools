function Get-DataLayer {

    [CmdletBinding()]
    param (        
        [Parameter(Mandatory, ValueFromPipeline)]
        [PSCustomObject] $Layer,

        [Parameter()]
        [switch] $Recurse
    )

    process {

        Write-Output $Layer

        if ( $Recurse.IsPresent ) {
            $Layer.Layer | 
            Where-Object { $_ } | 
            Get-DataLayer -Recurse
        }

    }
}