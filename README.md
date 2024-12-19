# Symon2CSV
 PowerShell script that parses Sysmon logs (specifically the "message" field) and converts them to a well-formatted CSV 

 My original objective was to perform data analysis on Windows Sysmon logs collected on my local machine in python with the logs in a Data Frame. The issue however was that the majority of useful information in Sysmon logs is contained within the "message" field and they are natively unparsed, so when sysmon logs are exfilled, all that information was jammed into one field. To tackle this problem I developed a short PowerShell script to do the following:

    1. Ask the which EventCode they would like to convert (for now it is by event code to ensure the csv is formatted as cleanly as possible and csvs/dfs can be manually combined within python/excel)

    2. Initialize a PowerShell array

    3. Initialize a new PowerShell Object for each event
    
    4. Parse the "message" field of each Sysmon event and add the data as "Properties" and "Values" to the event objects

    5. Add each object to the array

    6. Export the array as a CSV

There are many ways to accomplish this task of Parsing and no "right" way. I'm sure there are many SIEMs and Enterprise tools to accomplish this task as well, but this script is effective for clean, easy, local analysis.

*NOTE: The script may take a few minutes to run in order to parse a large number of events
