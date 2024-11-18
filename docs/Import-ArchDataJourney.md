---
external help file: PsArchTools-help.xml
Module Name: PsArchTools
online version:
schema: 2.0.0
---

# Import-ArchDataJourney

## SYNOPSIS
Imports a data journey.

## SYNTAX

### File
```
Import-ArchDataJourney -Path <FileInfo> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

### Directory
```
Import-ArchDataJourney -Directory <DirectoryInfo> [-ProgressAction <ActionPreference>] [<CommonParameters>]
```

## DESCRIPTION
Reads an export from file and deserializes it to a data journey.

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Path
The path of the export file, that should be imported.

```yaml
Type: FileInfo
Parameter Sets: File
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Directory
The path of the export file, that should be imported.

```yaml
Type: DirectoryInfo
Parameter Sets: Directory
Aliases:

Required: True
Position: Named
Default value: None
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
