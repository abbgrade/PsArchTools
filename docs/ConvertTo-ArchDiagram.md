---
external help file: PsArchTools-help.xml
Module Name: PsArchTools
online version:
schema: 2.0.0
---

# ConvertTo-ArchDiagram

## SYNOPSIS
Converts the roadmap to diagram.

## SYNTAX

### journey
```
ConvertTo-ArchDiagram -Title <String> [-Models <PSObject[]>] [-Flows <PSObject[]>] [-Layer <PSObject[]>]
 [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### roadmap
```
ConvertTo-ArchDiagram -Title <String> [-Features <PSObject[]>] [-Milestones <PSObject[]>]
 [-FeatureStates <Hashtable>] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Creates a mermaid flowchart to display the roadmap.

## EXAMPLES

### EXAMPLE 1
```
$Roadmap = New-ArchRoadmap 'Diagram Title'
PS> $Roadmap | Add-ArchFeature A 'do this' -Link 'https://www.github.com'
PS> $Roadmap | Add-ArchFeature B 'do that' -Link 'https://www.github.com'
PS> $Roadmap | Add-ArchMilestone C 'be epic' -DependsOn A, B
PS> $Roadmap | Add-ArchFeature D 'do whatever' -DependsOn C
PS> $Roadmap | Add-ArchFeature E 'do what else' -DependsOn C
PS> $Roadmap | ConvertTo-ArchDiagram
---
title: Diagram Title
---
flowchart
    classDef feature fill:#ffcc5c
    classDef milestone fill:#96ceb4
    A[do this]:::feature
    B[do that]:::feature
    D[do whatever]:::feature
    E[do what else]:::feature
    C[be epic]:::milestone
    click A "https://www.github.com" _blank
    click B "https://www.github.com" _blank
    C --> D
    C --> E
    A --> C
    B --> C
```

## PARAMETERS

### -Title
Title of the roadmap diagram.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Features
Features in the roadmap diagram.

```yaml
Type: PSObject[]
Parameter Sets: roadmap
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Milestones
Milestones in the roadmap diagram.

```yaml
Type: PSObject[]
Parameter Sets: roadmap
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FeatureStates
Feature states in the roadmap diagram.

```yaml
Type: Hashtable
Parameter Sets: roadmap
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Models
Models in the data journey diagram.

```yaml
Type: PSObject[]
Parameter Sets: journey
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Flows
Flows in the data journey diagram.

```yaml
Type: PSObject[]
Parameter Sets: journey
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Layer
Layer in the data journey diagram.

```yaml
Type: PSObject[]
Parameter Sets: journey
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ProgressAction
{{ Fill ProgressAction Description }}

```yaml
Type: ActionPreference
Parameter Sets: (All)
Aliases: proga

Required: False
Position: Named
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
