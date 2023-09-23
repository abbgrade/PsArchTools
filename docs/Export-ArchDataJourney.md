---
external help file: PsArchTools-help.xml
Module Name: PsArchTools
online version:
schema: 2.0.0
---

# Export-ArchDataJourney

## SYNOPSIS
Exports a data journey.

## SYNTAX

```
Export-ArchDataJourney [-DataJourney] <PSObject> [-Path] <FileInfo> [<CommonParameters>]
```

## DESCRIPTION
Serializes a data journey to YAML and writes it to file.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -DataJourney
The data journey that should be exported.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Path
The path of the export file, that should be created.

```yaml
Type: FileInfo
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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
