#
#
#
class gnome::install (
  $packages = ['xorg', 'xorg-xinit', 'gnome'],
  # xorg-server-utils xorg-server xf86-video-intel mesa-libgl xf86-input-evdev 
  # libx264 gnome-control-center gnome-disk-utility gnome-keyring gnome-screenshot gnome-session gnome-system-monitor gnome-system-log gnome-themes-standard gtk3-print-backends nautilus

) {
  package { $packages:
    ensure => present
  }
}
