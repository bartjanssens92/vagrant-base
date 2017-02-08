#
#
#
class profile_base::tools (
  $tools = [],
  $base_tools = ['vim', 'htop', 'iotop', 'net-tools', 'lsof']
) {
  # Install all the packages
  package { $base_tools:
    ensure => present,
  }
  # If there are any packages in the $tools array
  if !empty($tools) {
    package { $tools:
      ensure => present
    }
  }
}
