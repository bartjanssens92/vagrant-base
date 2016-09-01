#
# Role to setup a basic java/tomcat node
#
class roles::java () {

  include profile_base

  # Ensure that java is installed
  $dependencies = ['java-1.7.0-openjdk-headless.x86_64']

  package { $dependencies:
    ensure => present,
  }

} # class roles::java

