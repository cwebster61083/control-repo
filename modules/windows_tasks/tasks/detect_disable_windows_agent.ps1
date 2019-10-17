$service = Get-WmiObject -Class Win32_Service -Property StartMode -Filter "Name='Puppet'"

if($service.StartMode -eq "Disabled"){
  echo "Puppet agent is disabled"
  echo $?
}
else{
  write-error "Puppet agent is enabled"
  echo $?
} 
