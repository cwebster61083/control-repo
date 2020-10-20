class profiles::puppet_infra_base {
  package { 'toml-rb':
    ensure => 'present',
  }
}
