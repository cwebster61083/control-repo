# Plan to restart DP3 from automation
plan dp3::restart_dp3(
  Enum['development', 'qa', 'production'] $environment,
  Boolean                                 $noop = false,
) {
  $dp3_hosts = {
    'obge' => {
      'development' => 'sdoakv-eswcge01.dartcontainer.com',
      'qa'          => 'sqoakv-eswcge01.dartcontainer.com',
      'production'  => 'spmasv-eswcge01.dartcontainer.com',
      'service'     => 'BGMD',
    },
    'front_end' => {
      'development' => 'sdoakv-eswcfe01.dartcontainer.com',
      'qa'          => 'sqoakv-eswcfe01.dartcontainer.com',
      'production'  => 'spmasv-eswcfe01.dartcontainer.com',
      'service'     => 'WebCenter_Tomcat',
    },
    'app' => {
      'development' => 'sdoakv-eswcap01.dartcontainer.com',
      'qa'          => 'sqoakv-eswcap01.dartcontainer.com',
      'production'  => 'spmasv-eswcap01.dartcontainer.com',
      'service'     => 'WebCenter_CADX',
    },
  }
  #stop front end
  run_task('service', $dp3_hosts[front_end][$environment], action => 'stop', name => $dp3_hosts[front_end][service], _noop => $noop)
  # stop OBGE
  run_task('service', $dp3_hosts[obge][$environment], action => 'stop', name => $dp3_hosts[obge][service], _noop => $noop)
  # stop Applicaiton (using PowerShell as service module does not let us set a custom timeout)
  run_task('dp3::dp3_app_stopped', $dp3_hosts[app][$environment])
  # wait until 160 threads
  run_task('dp3::dp3_app_ready', $dp3_hosts[app][$environment])
  # Start CADX
  run_task('service', $dp3_hosts[app][$environment], action => 'start', name => $dp3_hosts[app][service], _noop => $noop)
  # start OBGE and front-end
  run_task('service', $dp3_hosts[obge][$environment], action => 'start', name => $dp3_hosts[obge][service], _noop => $noop)
  run_task('service', $dp3_hosts[front_end][$environment], action => 'start', name => $dp3_hosts[front_end][service], _noop => $noop)
}
