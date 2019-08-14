#Defualt profile
class profile::base {

  #the base profile should include component modules that will be on all nodes
  file { 'test.txt':
    ensure  => present,
    path    => '/tmp/test.txt',
    content => 'Some Text',
  }

}
