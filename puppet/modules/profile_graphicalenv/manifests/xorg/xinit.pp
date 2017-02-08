#
#
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
}
