[CmdletBinding()]
Param(
  # Mandatory is set to false. If Set to $True then a dialog box appears to get the missing information
  # We will do a variable check later
  # https://blogs.technet.microsoft.com/heyscriptingguy/2011/05/22/use-powershell-to-make-mandatory-           parameters/
  [Parameter(Mandatory = $False)]
  [String]$_installdir,
  [Boolean]$_noop = $false
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

$scriptBlock = {
  Import-Module "$_installdir\dp3\files\TaskUtils.ps1"

  Set-StrictMode -Version Latest
  $ErrorActionPreference = 'Stop'
  $ProgressPreference = 'SilentlyContinue'

  Stop-Service WebCenter_CADX
  Stop-Service WebCenter_JBoss
}
If ($_noop){
  ConvertTo-Json "We would stop the services but we are running NOOP."
  Exit 0
} Else {
  $results = Invoke-CommandAsLocal -ScriptBlock $scriptBlock
  ConvertTo-JSON $results.Command.Output
  exit $results.ExitCode
}