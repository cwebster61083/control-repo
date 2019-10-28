$starttime = Get-Date
$directory = "C:\"

$a = Get-ChildItem -Directory $directory -Recurse

$stoptime = Get-Date
$elapsedtime = $stoptime - $starttime

$elapsedtime 
