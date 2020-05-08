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

#############
# Variables #
#############

$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
$strServiceName = "WebCenter_JBoss"
$strProcessName = "wcr_jboss_srv"

# test to see if we are already running
Function Start-DP3_Application {
	Param 
	(
        [parameter(Mandatory=$true)]
	    [String] $ProcessName, 
	    [String] $ServiceName
	)
	
	$exit_code = 0
	$strOutput = "JBoss Service started"

	$objJBoss = Get-Process -Name $strProcessName
	If (!($objJBoss)) {
		# we are not running, start the process 
		Start-Service -Name $strServiceName
				
		#verify that service started, raise error if not
		$objJBoss = Get-Process -Name $strProcessName

		If (!($objJBoss)) {
			$strOutput = "JBoss Service could not be started"
			$exit_code = 1
		}
	}#end if not JBoss

	return @{
		'JbossProcess' = $objJBoss;
		'output' = $strOutput;
		'exit_code' = $exit_code;
	}
}

Function Wait-DP3_Application_Ready {
	Param 
	(
        [parameter(Mandatory=$true)]
	    [String] $ProcessName, 
	    [String] $ServiceName
	)

	$intReadyThreadCount = 160 # DP3 is ready when threadcount is this or greater
	$intPasses = 0
	$objStartJBoss = Start-DP3_Application -ProcessName $ProcessName -ServiceName $ServiceName
	$objJBoss = $objStartJBoss.JbossProcess
	$strOutput = $objStartJBoss.output
	$exit_code = $objStartJBoss.exit_code

	If ($exit_code -eq 0) {
		#Wait for thread count to rise above threshold. Raise error if takes too long or process stops
		If ($objJBoss.Threads.Count -lt $intReadyThreadCount) {
			$strOutput +=  "JBoss Thread Count: " + $objJBoss.Threads.Count

			While ($objJBoss.Threads.Count -lt $intReadyThreadCount -and $exit_code -eq 0) {
				Start-Sleep 5
				#Restart JBoss if it stops
				If (!($objJBoss)) {
					If ($intPasses -gt 4) {
						$strOutput += "We have attempted to start JBoss $intPasses times without success. Failing."
						$exit_code = 1
					} Else {
						$objStartJBoss = Start-DP3_Application -ProcessName $ProcessName -ServiceName $ServiceName
						$objJBoss = $objStartJBoss.JbossProcess
						$intPasses++
					}
				} #end if not JBoss

				#output the current thread count
				$strOutput +=  "JBoss Thread Count: " + $objJBoss.Threads.Count
			} #end While JBoss.Threads.Count -lt 160
		} #end if JBoss.Threads.Count -lt 160

		# Catch failure condition where loop exits while still not working, but exit is still good
		If ($exit_code -eq 0) {
			If ($objJBoss.Threads.Count -lt $intReadyThreadCount) {
				$exit_code = 1
			}
		}
	} #end If $exit_code = 0
	return @{
		'output' = $strOutput;
		'exit_code' = $exit_code;
	}
} # end Function Wait-DP3_Application_Ready

$start_jboss = Wait-DP3_Application_Ready -ProcessName $strProcessName -ServiceName $strServiceName
ConvertTo-Json $start_jboss.output
exit $start_jboss.exit_code