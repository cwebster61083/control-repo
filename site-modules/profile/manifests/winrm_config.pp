class profile::winrm_config {
    notify { 'This is the winrm profile': }

    # Add Puppet CA and the node's certificate to the local store
    class { 'windows_puppet_certificates':
        manage_master_cert => true,
        manage_client_cert => true,
    }
}
