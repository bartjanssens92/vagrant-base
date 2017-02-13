# Class profile_graphicalenv::xorg::xinit
#
# Private class to setup the xinitrc script in the users homedir.
#
# TO DO:
#  * Write a better template for the xinitrc file
#
class profile_graphicalenv::xorg::xinit (
  $to_start,
  $packages = ['xorg-xinit'],
  $user     = 'vagrant',
) {
  # Install the packages
  package { $packages:
    ensure => present,
  }
  # Added the xinitrc file
  file { "/home/${user}/.xinitrc":
    ensure  => present,
    owner   => $user,
    mode    => '0744',
    content => template('profile_graphicalenv/xorg/xinitrc.erb'),
  }
} # class profile_graphicalenv::xorg::xinit
