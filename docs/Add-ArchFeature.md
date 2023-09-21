---
external help file: PsArchTools-help.xml
Module Name: PsArchTools
online version:
schema: 2.0.0
---

# Add-ArchFeature

## SYNOPSIS
Adds a new feature to a roadmap.

## SYNTAX

```
Add-ArchFeature -Roadmap <Object> [-Id] <String> [-Title] <String> [-Link <String>] [-DependsOn <String[]>]
 [-PassThru] [<CommonParameters>]
```

## DESCRIPTION
Creates and adds a feature to a previously created roadmap object.

## EXAMPLES

### EXAMPLE 1
```
$Roadmap = New-ArchRoadmap -Title MyRoadmap
PS> $Roadmap | Add-ArchFeature -Id 4711 -Title MyFeature
```

## PARAMETERS

### -Roadmap
The roadmap, the feature is added to.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Id
The identifier of the feature.
E.g.
the ticket number.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title
The title of the feature.

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

### -Link
A link to the feature in the agile board.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DependsOn
Features or milestones that must be completed, before the feature can be implemented.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
Switch that specifies, if the feature should be returned instead of only added to the roadmap.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS
