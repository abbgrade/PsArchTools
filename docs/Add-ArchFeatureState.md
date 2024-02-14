---
external help file: PsArchTools-help.xml
Module Name: PsArchTools
online version:
schema: 2.0.0
---

# Add-ArchFeatureState

## SYNOPSIS
Adds a new feature state difinition to a roadmap.

## SYNTAX

```
Add-ArchFeatureState [-Roadmap] <Object> [-Style] <String> [[-State] <String>] [<CommonParameters>]
```

## DESCRIPTION
Creates and adds a feature state to a previously created roadmap object.
It is used to customize the style in the diagram.

## EXAMPLES

### EXAMPLE 1
```
$Roadmap = New-ArchRoadmap -Title MyRoadmap
PS> $Roadmap | Add-ArchFeatureState -State Done -Style 'fill:#86c787'
```

Fill the feature in state Done in color #86c787.

## PARAMETERS

### -Roadmap
The roadmap, the feature state is added to.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Style
Mermaid style string.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -State
Name of the feature state.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
