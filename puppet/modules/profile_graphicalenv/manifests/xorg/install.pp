# Class profile_graphicalenv::xorg::install
#
# Private class to install all the Xorg packages.
#
class profile_graphicalenv::xorg::install (
  $packages = ['xorg', 'xorg-xinit'],
  $packages_xorg = ['xorg-server-utils','xorg-server','xf86-video-intel','mesa-libgl','xf86-input-evdev'],
) {
  # Remove the nox package and get the full utils
  package { 'virtualbox-guest-utils-nox':
    ensure => absent,
  }
  package { 'virtualbox-guest-utils':
    ensure  => present,
    require => Package['virtualbox-guest-utils-nox'],
  }
  # Install the xorg server
  package { $packages_xorg:
    ensure  => present,
    require => Package['virtualbox-guest-utils'],
  }
} # class ::profile_graphicalenv::xorg::install
