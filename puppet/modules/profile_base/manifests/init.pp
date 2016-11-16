#
# Base class, will provision the vm to be used.
# The class manages:
#   - cron
#   - exim4
#   - firewall ( done )
#   - monitoring
#   - network
#   - ntp ( done )
#   - repos
#   - rsyslog
#   - selinux ( done )
#   - sudoers ( done )
#   - users ( done )
#
class profile_base (
  $manage_users = 'hiera',
  $enable_firewall = true,
) {

  #include ::selinux
  include ::ntp
  include ::sudo
  include ::sudo::configs

  if ( str2bool($enable_firewall) ) {
    include ::profile_base::firewall
  } else {
    class { '::firewall':
      ensure => stopped,
    }
  }

  if ( $manage_users == 'hiera' ) {
    $default_group_ = {
      'users' => {
        'gid' => 100,
      },
    }
    $default_user_ = {
      'default'  => {
        'pwhash' => '$1$/E6bBiy5$JOVPppt.Yn7JJ.cBHE14z1', #default
      }
    }

    class { 'accounts':
      users  => hiera_hash('users', $default_user_),
      groups => hiera_hash('groups', $default_group_),
    }
  }

} # class profile_base
