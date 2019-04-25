# Example 1
## This will search through the event log named Application (or in Swedish: Applikation) for any event where the message contains the string "significant"
get-eventlog -LogName Application -Message "*significant*"

# Example 2
## This example will search through the eventlog System for events where the message begins with the string "I'm first"
get-eventlog -LogName System -Message "I'm first*"

# Example 3
<# This example would connect to the computer TheOtherComputer and search through the eventlog TheLogOfYourChoice 
   (Application is the most commonly used) for all events that happened after the date 2019-03-25 and after 00:00:00 
   (i.e the start of the day) that was saved by the source AppOfChoice #>
<# It's a bit convoluted, but Get-Eventlog requires a DateTime object for -After and -Before.
   In a script, I would create two variables to make it easier to read/reuse #>
get-eventlog -ComputerName TheOtherComputer -LogName TheLogOfYourChoice -Source AppOfChoice -After $(Get-Date -Date "2019-03-25 00:00:00")
