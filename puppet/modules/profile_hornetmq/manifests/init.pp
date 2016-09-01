#
# Needed to disable AIO by setting the following line in 'hornetmq-configuration.xml':
# <journal-type>NIO</journal-type>
#
class profile_hornetmq (
  $packages = ['libaio'],
) {

  # Dependencies
  package { $packages:
    ensure => present,
  }

  # Java
  # For now just install the package
  # should be managed with a module
  # and a profile_java or smth
  package { 'java-1.8.0-openjdk-headless.x86_64':
    ensure => present,
  }
}
