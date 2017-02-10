#
#
#
class profile_graphicalenv::i3::install (
  $packages = ['i3-wm','i3lock','i3status'],
  $fonts    = ['adobe-source-code-pro-fonts'],
  $extra    = ['dmenu', 'feh'],
) {
  package { $packages:
    ensure => present,
  }
  # i3 uses a monospace font by default,
  # but it's not included as standart
  package { $fonts:
    ensure => present,
  }
  # extra packages that are nice to have
  package { $extra:
    ensure => present,
  }
}
