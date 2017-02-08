#
#
#
class profile_graphicalenv::i3::install (
  $packages = ['i3-wm','i3lock','i3status'],
) {
  package { $packages:
    ensure => present,
  }
}
