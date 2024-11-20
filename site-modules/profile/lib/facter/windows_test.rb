Facter.add('win_license_status_esu') do
  confine :kernel => 'windows'
  setcode do
    ps_command = <<-EOH
    Get-CimInstance SoftwareLicensingProduct -Filter \\"Name like 'Windows%'\\" |
    Where-Object { $_.PartialProductKey -eq ' 63DFG '} |
    Select-Object -ExpandProperty LicenseStatus
EOH

# Execute the PowerShell command
result = Facter::Core::Execution.execute("powershell.exe -NoProfile -ExecutionPolicy Bypass -Command \"#{ps_command}\"", :timeout => 30)

# Log the raw output for debugging purposes
Facter.debug("LicenseStatus PowerShell output: #{result.strip}")

# Return the LicenseStatus as an integer
win_license_status12 = result.strip.to_i

# Debug log the interpreted license status
Facter.debug("Interpreted LicenseStatus: #{license_status}")

win_license_status
end
end

I've attached the job rub in debug mode where the given node having the job run against it should have facter resolve the custom fact as well.