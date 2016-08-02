#
# Apache profile
# This should setup apache with the desired config
# It also manages the vhosts as using "apache::vhosts::vhosts:" gives this error:
# Error: Duplicate declaration: Class[Apache] is already declared; cannot redeclare at /tmp/vagrant-puppet/modules-a2aa1f5cb51d7670d73e82c075a0a4ac/profile_apache/manifests/init.pp:48
#
  #$vhosts = hiera(vhosts),
class profile_apache (
  $vhosts = {},
  $docroot = '/var/vhosts',
) {
  # Setup apache
  class { 'apache':
    default_mods           => true,
    default_vhost          => false,
    docroot                => '/var/vhosts/default',
    default_charset        => 'utf-8',
    default_confd_files    => true,
    #need to setup ssl with let'sencrypt
    #default_ssl_vhost      => false,
    #default_ssl_cert       => $::apache::params::default_ssl_cert,
    #default_ssl_key        => $::apache::params::default_ssl_key,
    #default_ssl_chain      => undef,
    #default_ssl_ca         => undef,
    #default_ssl_crl_path   => undef,
    #default_ssl_crl        => undef,
    #default_ssl_crl_check  => undef,
    service_enable         => true,
    service_manage         => true,
    service_ensure         => 'running',
    service_restart        => undef,
    purge_configs          => true,
    purge_vhost_dir        => false,
    purge_vdir             => false,
    serveradmin            => 'bbq92@localhost',
    sendfile               => 'On',
    error_documents        => false,
    timeout                => '120',
    vhost_dir              => '/etc/httpd/vhosts',
    rewrite_lock           => undef,
    manage_user            => true,
    manage_group           => true,
    limitreqfieldsize      => '8190',
    log_formats            => {},
    server_tokens          => 'OS',
    server_signature       => 'On',
    trace_enable           => 'On',
    allow_encoded_slashes  => undef,
    package_ensure         => 'installed',
    root_directory_secured => false,
  }

  # Create the 'top' docroot
  file { $docroot:
    ensure => directory,
  }

  # Create the vhosts
  create_resources('apache::vhost', $vhosts)

  # Add firewall rules
  if ( str2bool($::profile_base::enable_firewall) ) {
    firewall { '006 Allow inbound on port 80 and 443 tcp':
      dport  => [80,443],
      proto  => tcp,
      action => 'accept',
    }

    firewall { '006 Allow inbound on port 80 and 443 udp':
      dport  => [80,443],
      proto  => udp,
      action => 'accept',
    }
  }
}
