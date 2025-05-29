plan test::windows_agent_upgrade (
  TargetSpec $targets,
) {
  $targets.apply_prep
  $primary_facts = run_task('facts', $targets, '_catch_errors' => true).first

  $apply_results = apply($targets) {
    dsc_scheduledtask { 'Puppet - Set Duo Configuration' :

        dsc_taskname           => 'Puppet - Set Duo Configuration',

        dsc_enable             => true,

        dsc_ensure             => 'Present',

        dsc_actionexecutable   => 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe',

        dsc_actionarguments    => 'whoami',

        dsc_scheduletype       => 'Once',

        dsc_repeatinterval     => "00:15:00",

        dsc_repetitionduration => 'indefinitely',

        dsc_startwhenavailable => true,

        dsc_randomdelay        => '00:10:00',

      }
  }
}
