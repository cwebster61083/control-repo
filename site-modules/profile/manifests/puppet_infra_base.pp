class profiles::puppet_infa_base {
  package { 'toml-rb':
    ensure => 'present',
  }
}
