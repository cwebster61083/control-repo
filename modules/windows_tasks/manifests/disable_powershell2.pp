# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include windows_tasks::disable_powershell2
class windows_tasks::disable_powershell2 {
  dsc {'WindowsOptionalFeature':
    resource_name => 'WindowsFeature',
    module        => 'PSDesiredStateConfiguration',
    properties    => {
      ensure  => 'Disable',
      name    => 'MicrosoftWindowsPowershellV2',
  }
}

