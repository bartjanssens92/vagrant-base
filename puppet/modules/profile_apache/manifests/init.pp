#
# Apache profile
# This should setup apache with the desired config
# It should not manage the vhosts as that is included in the module
#
class profile_apache () {

  class { 'apache':
    $default_mods           = true,
    $default_vhost          = false,
    $default_charset        = 'utf-8',
    $default_confd_files    = true,
    #need to setup ssl with let'sencrypt
    #$default_ssl_vhost      = false,
    #$default_ssl_cert       = $::apache::params::default_ssl_cert,
    #$default_ssl_key        = $::apache::params::default_ssl_key,
    #$default_ssl_chain      = undef,
    #$default_ssl_ca         = undef,
    #$default_ssl_crl_path   = undef,
    #$default_ssl_crl        = undef,
    #$default_ssl_crl_check  = undef,
    $service_enable         = true,
    $service_manage         = true,
    $service_ensure         = 'running',
    $service_restart        = undef,
    $purge_configs          = true,
    $purge_vhost_dir        = false,
    $purge_vdir             = false,
    $serveradmin            = 'bbq92@localhost',
    $sendfile               = 'On',
    $error_documents        = false,
    $timeout                = '120',
    $vhost_dir              = '/var/vhosts'
    $rewrite_lock           = undef,
    $manage_user            = true,
    $manage_group           = true,
    $limitreqfieldsize      = '8190',
    $log_formats            = {},
    $server_tokens          = 'OS',
    $server_signature       = 'On',
    $trace_enable           = 'On',
    $allow_encoded_slashes  = undef,
    $package_ensure         = 'installed',
    $root_directory_secured = false,
  }
}
