class profile::puppet_infra_base {
  package { 'toml-rb':
    ensure   => 'present',
    provider => 'puppet_gem',
    root     => true,
  }
}
