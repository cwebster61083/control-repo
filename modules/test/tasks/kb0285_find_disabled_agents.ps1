$LOCKFILE="$(cmd.exe /c "C:\Program Files\Puppet Labs\Puppet\bin\puppet.bat" config print statedir)/agent_disabled.lock"

if(Test-Path $LOCKFILE) {
  Write-Output "Puppet agent is disabled"
  cat $LOCKFILE
}
else {
  Write-Output "Puppet agent is enabled"
  EXIT 1
} 
