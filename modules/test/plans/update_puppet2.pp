plan test::update_puppet2(
  TargetSpec $targets,
  # String $version,
) {
  # $targets.apply_prep
  # $primary_facts = run_task('facts', $targets, '_catch_errors' => true).first

  # run_task ('service', $targets, 'action' => 'stop', 'name' => 'puppet')
  # run_task ('service', $targets, 'action' => 'stop', 'name' => 'pxp-agent')

  run_task('puppet_agent::install', $targets, 'version' => '7.25.0', 'stop_service' => 'true')

  # run_task ('service', $targets, 'action' => 'start', 'name' => 'puppet')
  # run_task ('service', $targets, 'action' => 'start', 'name' => 'pxp-agent')
  # run_command("Get-Service -DisplayName 'Puppet PXP Agent' -ErrorAction SilentlyContinue | Stop-Service", $targets)

  # run_task('puppet_agent::install', $targets, 'version' => $version)
}
