# Class profile_graphicalenv::i3::install
#
# Private class to install all the i3 packages.
# Also includes the fonts to install as they aren't included.
# And some extra packages to make life more confortable.
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
  # but it's not included as standard
  package { $fonts:
    ensure => present,
  }
  # extra packages that are nice to have
  package { $extra:
    ensure => present,
  }
} # class profile_graphicalenv::i3::install
