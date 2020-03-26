class role::windows {
    notify {'This is the Windows role!': }
    
    include profile::base
    include profile::winrm
}
