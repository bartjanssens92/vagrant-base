#
#
#
class profile_graphicalenv::i3::install (
  $packages = ['i3-wm','i3lock','i3status'],
  $fonts    = ['adobe-source-code-pro-fonts'],
) {
  package { $packages:
    ensure => present,
  }
  # i3 uses a monospace font by default,
  # but it's not included as standart
  package { $fonts:
    ensure => present,
  }
}
