[CmdletBinding()]
Param (
  [String]$noop,
  [String]$tags
)
$error.clear()
$ErrorActionPreference = "Stop"
$OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding
$PAgentConfigArg = @()
$PAgentConfigArg += "agent"
$PAgentConfigArg += "-t"

write-output "bool info for noop" $noop.gettype().fullname

write-output "Noop = $noop"
write-output "Tags = $tags"

write-output "Config = $paagentconfigarg"

if ($noop) {
  write-output "value indicates true and should be adding noop"
  $PAgentConfigArg += '--noop'
}
else {}

write-output "post noop check" $pagentconfigarg

if ($tags -ne "") {
  $PAgentConfigArg += "--tags $tags"
}
else {}

write-output "post tag command" $pagentconfigarg

$PuppetArguments = $PAgentConfigArg -join ' '
Write-Output "**** Install Arguments : $PuppetArguments"
Write-Output "**** executing command, please wait…"
# $pcmdstatus = (Start-Process -FilePath "C:\Program Files\Puppet Labs\Puppet\bin\puppet.bat" -ArgumentList $PuppetArguments -Wait -Passthru).ExitCode
If ($pcmdstatus -eq 0)
{ write-output "success" }
else
{ write-output "Failed miserably" }