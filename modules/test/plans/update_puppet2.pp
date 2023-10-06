plan test::update_puppet2(
  TargetSpec $targets,
) {
  # $targets.apply_prep
  # $primary_facts = run_task('facts', $targets, '_catch_errors' => true).first

  run_command("Get-Service -DisplayName 'Puppet Agent' -ErrorAction SilentlyContinue | Stop-Service", $targets)
  run_command("Get-Service -DisplayName 'Puppet PXP Agent' -ErrorAction SilentlyContinue | Stop-Service", $targets)

  run_task('puppet_agent::install', $targets, 'version' => '7.25.0')
}
