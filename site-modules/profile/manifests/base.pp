#Defualt profile
class profile::base {

  #the base profile should include component modules that will be on all nodes
  include test::whoamia
  notify {'running from site.pp':}

}
