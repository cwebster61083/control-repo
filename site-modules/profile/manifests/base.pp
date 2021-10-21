#Defualt profile
class profile::base {

  notify {'This is the base profile!':}

  include puppet_run_scheduler

  $runinterval = 30 #minutes

  $first_run = fqdn_rand($runinterval)
  $second_run = $first_run + $runinterval

  cron { 'cron.puppet':
    command => '/opt/puppetlabs/bin/puppet agent -t > /dev/null',
    user    => 'root',
    minute  => [ $first_run, $second_run ],
  }

  make sure we haven't started the puppet daemon ever
  this may cause the report on an agent that triggers this via a daemonized run to not be submitted

  service { 'puppet':
    ensure  => stopped,
    enable  => false,
    require => Cron['cron.puppet'],
    }
}
