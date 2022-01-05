# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include bpa_laps::install
class bpa_laps::install {

  #install the package silently and do not reboot
  package { 'laps':
    ensure   => 'installed',
    provider => 'chocolatey',
  }
}
