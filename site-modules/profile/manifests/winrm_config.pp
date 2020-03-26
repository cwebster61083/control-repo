class profile::winrm_config {
    notify { 'This is the winrm profile': }

    # Add Puppet CA and the node's certificate to the local store
    class { 'windows_puppet_certificates':
        manage_master_cert => true,
        manage_client_cert => true,
    }
    winrmssl {'Puppet Enterprise CA':
      ensure       => present,
      issuer       => $facts['puppet_cert_paths']['ca_path'],
      disable_http => false,
      require      => Class['windows_puppet_certificates']
    }
    windows_firewall_rule {
        default:
            ensure   => present,
            action   => 'allow',
            protocol => 'tcp',
            profile  => ['public','private','domain'],
        ;
        'Windows Remote Management (HTTPS-In)':
            local_port    => '5986',
            remote_address => '10.16.132.168',
            description => 'Inbound rule for Windows Remote Management via WS-Management. [TCP 5986]',
        ;
        'Windows Remote Management (HTTP-In)':
            local_port    => '5985',
            local_address => '127.0.0.1',
            description   => 'Restricted inbound rule for local Management via WS-Management. [TCP 5985]',
    }
}
