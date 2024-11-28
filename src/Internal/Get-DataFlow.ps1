function Get-DataFlow {

    [CmdletBinding()]
    param (
        # The flows to scan the data flow for.
        [Parameter( ValueFromPipelineByPropertyName )]
        $Flows,

        # The layers to scan the data flow for.
        [Parameter( ValueFromPipelineByPropertyName )]
        $Layer,

        # If specified, only return data flows with the matching key.
        [Parameter()]
        [string[]] $Key,

        # If specified, scan the layers recursively.
        [Parameter()]
        [switch] $Recurse
    )

    process {

        $Flows | ForEach-Object { Write-Output $_ } | Where-Object { (-not $Key) -or ($_.Key -in $Key) }

        if ( $Recurse.IsPresent ) {
            $Layer |
            Where-Object { $_ } |
            Get-DataFlow -Key:$key -Recurse
        }

    }
}