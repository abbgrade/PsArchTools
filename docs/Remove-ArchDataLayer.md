---
external help file: PsArchTools-help.xml
Module Name: PsArchTools
online version:
schema: 2.0.0
---

# Remove-ArchDataLayer

## SYNOPSIS
Removes an existing data layer from a data journey.

## SYNTAX

```
Remove-ArchDataLayer -Parent <Object> [-Key] <String[]> [-Recurse] [-ProgressAction <ActionPreference>]
 [<CommonParameters>]
```

## DESCRIPTION
Removes an existing data layer from a data journey or data layer.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Parent
The data journey or parent layer, the layer is removed from.

```yaml
Type: Object
Parameter Sets: (All)
Aliases: Journey

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Key
The identifier key of the layer.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Recurse
Remove the layer if found in sub-layers recursively if found.

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
