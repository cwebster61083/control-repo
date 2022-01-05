# A description of what this class does
#
# @summary A short summary of the purpose of this class
#
# @example
#   include bpa_laps
class bpa_laps {
    contain bpa_laps::install
    contain bpa_laps::registry
      Class[::bpa_laps::registry]
      -> Class[::bpa_laps::install]
}