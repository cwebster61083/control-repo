class profile::hdp_profile {

  class { 'hdp::app_stack':
          ca_server                    => 'https://clwpe2019-b5fe62-0.us-west1-c.c.customer-support-scratchpad.internal:8140',
          dns_name                     => 'clw2019-b5fe62-0.us-west1-c.c.customer-support-scratchpad.internal',
          image_repository             => 'gcr.io/hdp-gcp-316600',
          minio_image                  => 'gcr.io/hdp-gcp-316600/puppet/minio:RELEASE.2021-07-30T00-02-00Z',
          redis_image                  => 'gcr.io/hdp-gcp-316600/puppet/redis:6.2.4-buster'
          version                      => 'demo-0.0.2'
          ui_use_tls                   => true,
          ui_cert_files_puppet_managed => false,
      }
}
