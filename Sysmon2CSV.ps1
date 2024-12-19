### Sysmon Parser Script intended to ingest Sysmon security events and parse the fields, specifically the message field, into a csv that is suitable for analysis ###

# Take user input for which event code they want to convert to csv and where they want it saved

$EventCode = Read-Host("What event code would you like to parse?") 
$Path = Read-Host("Where would you like to save this csv? (Include file name and specify full path)")

# Initialize array that will store each parsed event as an object

$logs = @()

# Query Logs

Get-WinEvent -LogName "Microsoft-Windows-Sysmon/Operational" | 

where-object {$_.id -eq [int]$EventCode } | 

# Parse the message field using regex to turn each unparsed key value pair in the message field into a property value pair in a new object

foreach-object {
    $message = $_.Message
    $obj = New-Object PSObject
    $obj | Add-Member -MemberType NoteProperty -Name "Event Code" -Value $EventCode
    $message -split "`n" | ForEach-Object {
        if ($_ -match "^(.*?):\s+(.*)$") {
            $obj | Add-Member -MemberType NoteProperty -Name $matches[1].Trim() -Value $matches[2].Trim()
            
            }
        }

        #Add each event object to the $logs array
        
        $logs += $obj
    }

# Export the array to a csv
 
$logs | Export-csv -Path $Path -NoTypeInformation