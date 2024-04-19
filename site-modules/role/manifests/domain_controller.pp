class role::domain_controller {
  notify { 'This is the domain controller role!': }
  include profile::base
}
