class profile::hdp_profile {

  class { 'hdp::app_stack':
          ca_server                    => 'https://clwpe2019-b5fe62-0.us-west1-c.c.customer-support-scratchpad.internal:8140',
          dns_name                     => 'clwpe2019-b5fe62-0.us-west1-c.c.customer-support-scratchpad.internal',
          image_repository             => 'gcr.io/hdp-gcp-316600',
          hdp_version                  => 'latest',
          ui_use_tls                   => true,
          ui_cert_files_puppet_managed => false,
      }
}
