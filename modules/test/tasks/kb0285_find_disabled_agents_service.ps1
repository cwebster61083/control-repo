$service = Get-WmiObject -Class Win32_Service -Property StartMode -Filter "Name='Puppet'"

if ($service.StartMode -eq "Disabled") {
  echo "Puppet agent is disabled"
}
else {
  echo "Puppet agent is enabled"
  EXIT 1
} 


$LOCKFILE="$(puppet config print statedir)/agent_disabled.lock"

if [ -e "$LOCKFILE" ] 
then
  echo "Puppet agent is disabled"
  cat "$(puppet config print statedir)/agent_disabled.lock"
else
  echo "Puppet agent is enabled"
  exit 1
fi

