# Class: cowsay
#
#
class cowsay {
  package { 'rubygems':
    ensure => 'present',
  }

  package { 'cowsay':
    ensure   => present,
    provider => 'gem',
    require  => Package['rubygems'],
  }
}
