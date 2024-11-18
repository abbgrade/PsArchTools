---
external help file: PsArchTools-help.xml
Module Name: PsArchTools
online version:
schema: 2.0.0
---

# Add-ArchDataFlow

## SYNOPSIS
Adds a new data flow to a data journey.

## SYNTAX

### Properties
```
Add-ArchDataFlow -Journey <Object> [-Key] <String> [[-Title] <String>] -Sources <String[]> -Sinks <String[]>
 [-PassThru] [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### InputObject
```
Add-ArchDataFlow -Journey <Object> -InputObject <PSObject> [-PassThru] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Creates and adds a data flow to a data journey. 
If the source or the sink models are not defined, they will be created implicitly.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Journey
The data journey, the data flow is added to.

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

### -Key
The identifier key of the data flow.

```yaml
Type: String
Parameter Sets: Properties
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Title
The title of the data flow.

```yaml
Type: String
Parameter Sets: Properties
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Sources
The source models of tha data flow

```yaml
Type: String[]
Parameter Sets: Properties
Aliases: Source

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Sinks
The sink models of tha data flow

```yaml
Type: String[]
Parameter Sets: Properties
Aliases: Sink

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -InputObject
The data flow is added to the data journey.

```yaml
Type: PSObject
Parameter Sets: InputObject
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PassThru
Switch that specifies, if the model should be returned instead of only added to the data journey.

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
