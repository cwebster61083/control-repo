$service = Get-WmiObject -Class Win32_Service -Property StartMode -Filter "Name='Puppet'"

if($service.StartMode -eq "Disabled"){
  Write-Error "Puppet agent is disabled"
  echo $?
}
else{
  echo "Puppet agent is enabled"
  echo $?
} 
