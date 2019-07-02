file { '/etc/motd':
  ensure  => 'present',
  owner   => 'root',
  group   => 'root',
  content => 'Hello world! Puppet is awesome.',
}
