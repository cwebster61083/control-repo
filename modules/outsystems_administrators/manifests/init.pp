# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include outsystems_administrators
class outsystems_administrators (
  $os_admins = 'webster.prv\\puppet_admins',
) {
  # include outsystems_administrator::services
  group {'Outsystems Administrators':
    ensure          => present,
    name            => 'Administrators',
    members         => $os_admins,
    auth_membership => false,
    # notify          => Service['OutSystems Deployment Service'],
  }
}
