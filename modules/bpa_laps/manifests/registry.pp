# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include bpa_laps::registry
class bpa_laps::registry {

  registry::value { 'PasswordComplexity':
    key   => 'HKLM:\Software\Policies\Microsoft Services\AdmPwd',
    value => 'PasswordComplexity',
    type  => 'dword',
    data  => '4',
  }

  registry::value { 'PasswordLength':
    key   => 'HKLM:\Software\Policies\Microsoft Services\AdmPwd',
    value => 'PasswordLength',
    type  => 'dword',
    data  => '25',
  }

  registry::value { 'PasswordAgeDays':
    key   => 'HKLM:\Software\Policies\Microsoft Services\AdmPwd',
    value => 'PasswordAgeDays',
    type  => 'dword',
    data  => '30',
  }

  registry::value { 'PwdExpirationProtectionEnabled':
    key   => 'HKLM:\Software\Policies\Microsoft Services\AdmPwd',
    value => 'PwdExpirationProtectionEnabled',
    type  => 'dword',
    data  => '1',
  }

  registry::value { 'AdmPwdEnabled':
    key   => 'HKLM:\Software\Policies\Microsoft Services\AdmPwd',
    value => 'AdmPwdEnabled',
    type  => 'dword',
    data  => '1',
  }

}
