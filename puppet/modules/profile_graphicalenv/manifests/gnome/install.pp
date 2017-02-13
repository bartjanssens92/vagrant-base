# Class profile_graphicalenv::gnome::install
#
# Class to install all the gnome packages.
#
class profile_graphicalenv::gnome::install (
  $packages_gnome = ['libx264','gnome-control-center','gnome-disk-utility','gnome-keyring','gnome-screenshot','gnome-session','gnome-system-monitor','gnome-system-log','gnome-themes-standard','gtk3-print-backends','nautilus'],
  $packages_session = ['gdm'],

) {
  package { $packages_gnome:
    ensure => present,
  }
  package { $packages_session:
    ensure => present,
  }
  service { 'gdm':
    ensure => running,
  }
} # class profile_graphicalenv::gnome::install
