#
#
#
class profile_graphicalenv::deepin::install (
  $packages = [
    'deepin-account-faces', 'deepin-api', 'deepin-artwork-themes', 'deepin-calendar', 'deepin-control-center', 'deepin-daemon', 'deepin-desktop', 'deepin-desktop-base', 'deepin-desktop-schemas', 'deepin-dock', 'deepin-file-manager', 'deepin-grub2-themes', 'deepin-gtk-theme', 'deepin-help', 'deepin-image-viewer', 'deepin-launcher', 'deepin-manual', 'deepin-menu', 'deepin-notifications', 'deepin-qt5integration', 'deepin-session-ui', 'deepin-shortcut-viewer', 'deepin-social-sharing', 'deepin-sound-theme', 'deepin-wallpapers', 'deepin-wm-switcher', 'startdde'
  ],
) {
  package { $packages:
    ensure => present,
  }
}

