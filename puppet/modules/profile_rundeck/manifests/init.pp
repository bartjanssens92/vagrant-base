#
# Profile for managing rundeck
#
# Using the following modules:
#  - https://github.com/voxpupuli/puppet-rundeck.git
#  - https://github.com/puppetlabs/puppetlabs-java.git
#  - https://github.com/voxpupuli/puppet-archive.git
#
class profile_rundeck (
  $user  = 'rundeck',
  $group = 'rundeck',
  $home  = '/home/rundeck',
) {

  # Setup rundeck
  include ::stdlib
  class { 'rundeck':
    group                 => $group,
    #java_home             => '/opt/java-',
    #jvm_args              => '',
    projects_storage_type => 'filesystem',
    rdeck_home            => $home,
    user                  => $user,
  }

  # Setup java
  # java-1.8.0_51/jre/
  java::oracle { 'jre1.8':
    ensure       => present,
    version      => 8,
    java_se      => 'jre',
    install_path => '/opt/java-1.8',
  }
}
