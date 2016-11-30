#
#
#
class tipboard () {
  # Install the python2 packages
  $packages = ['python2', 'python2-virtualenv', 'python2-pip']
  package { $packages:
    ensure => present,
  }

  # Make symlinks for pip
  file { '/usr/bin/python':
    ensure  => link,
    target  => '/usr/bin/python2',
    require => Package['python2'],
    before  => Package['tipboard'],
  }

  file { '/usr/bin/pip':
    ensure  => link,
    target  => '/usr/bin/pip2',
    require => Package['python2-pip'],
    before  => Package['tipboard'],
  }

  # Install the tipboard package
  package { 'tipboard':
    provider => 'pip',
    ensure   => present,
  }
}
