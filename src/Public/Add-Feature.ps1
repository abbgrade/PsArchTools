function Add-Feature {

    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline, Mandatory)]
        [ValidateNotNull()]
        $Roadmap,

        [Parameter(Mandatory, Position=0)]
        [ValidateNotNullOrEmpty()]
        [string] $Id,

        [Parameter(Mandatory, Position=1)]
        [ValidateNotNullOrEmpty()]
        [string] $Title,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string] $Link,

        [Parameter()]
        [string[]] $DependsOn,

        [Parameter()]
        [switch] $PassThru
    )

    process {
        $feature = [PSCustomObject]@{
            Id    = $Id
            Title = $Title
        }

        if ( $Link ) {
            $feature | Add-Member Link $Link
        }

        if ( $DependsOn ) {
            $feature | Add-Member Dependencies $DependsOn
        }

        $Roadmap.Features += $feature

        if ( $PassThru.IsPresent ) {
            Write-Output $feature
        }
    }
}