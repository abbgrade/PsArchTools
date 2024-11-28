function Select-DataJourneyLayer {

    [CmdletBinding()]
    param (
        # Data journey to select from.
        [Parameter(Mandatory, ValueFromPipeline)]
        [PSCustomObject] $Parent,

        [Parameter( Mandatory )]
        $Target,

        # Models in the data journey diagram.
        [Parameter()]
        [string[]] $Model,

        # Flows in the data journey diagram.
        [Parameter()]
        [string[]] $Flow,

        # Layer in the data journey diagram.
        [Parameter()]
        [string[]] $Layer
    )

    process {

        # copy layers
        $Parent.Layer | Where-Object { $_ } | Where-Object {
            ( $_.Key -in $Layer ) -or ( -not $Layer )
         } | ForEach-Object {
            $layerParameter = @{}
            if ( $_.Title ) {
                $layerParameter.Title = $_.Title
            }
            $layerCopy = $Target | Add-DataLayer -Key $_.Key @layerParameter -PassThru
            $_ | Select-DataJourneyLayer -Target $layerCopy -Model:$Model -Flow:$Flow -Layer:$Layer
        }

        # copy models
        $Parent.Models | Where-Object { $_ } | Where-Object {
            ( $_.Key -in $Model ) -or ( -not $Model )
        } | ForEach-Object {
            $modelParameter = @{}
            if ( $_.Class ) {
                $modelParameter.Class = $_.Class
            }
            $Target | Add-DataModel -Key $_.Key -Title $_.Title @modelParameter
        }

        # copy flows
        $Parent.Flows | Where-Object {
            ( $_.Key -in $Flow ) -or ( -not $Flow )
        } | ForEach-Object {
            $flowParameter = @{}

            if ( $_.Title ) {
                $flowParameter.Title = $_.Title
            }

            if ( $_.Sources ) {
                $flowParameter.Source = $_.Sources
            }

            if ( $_.Sinks ) {
                $flowParameter.Sink = $_.Sinks
            }

            $Target | Add-DataFlow -Key $_.Key @flowParameter
        }

    }
}