function Get-DataFlow {

    [CmdletBinding()]
    param (        
        [Parameter( ValueFromPipelineByPropertyName )]
        $Flows,
        
        [Parameter( ValueFromPipelineByPropertyName )]
        $Layer,

        [Parameter()]
        [switch] $Recurse
    )

    process {

        $Flows | ForEach-Object { Write-Output $_ }

        if ( $Recurse.IsPresent ) {
            $Layer | 
            Where-Object { $_ } | 
            Get-DataFlow -Recurse
        }

    }
}