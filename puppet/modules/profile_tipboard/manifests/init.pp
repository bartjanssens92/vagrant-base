#
#
#
class profile_tipboard (
  $tipboard_user = 'tipboard',
  $tipboard_group = 'tipboard',
  $tipboard_home = '/opt/tipboard',
) {

  include ::redis

  # Create the tipboard user and group
  group { $tipboard_group:
    ensure => present,
    system => true,
  }

  user { $tipboard_user:
    ensure     => present,
    home       => $tipboard_home,
    groups     => $tipboard_group,
    managehome => true,
    system     => true,
    require    => Group[$tipboard_group],
  }

  # Setup a new virtualenv for tipboard
  $python_version = '2.7'
  $virtualenv_source = 'bin/activate'
  $python_packages = {
    'Archlinux' => {
      latest => ['python', 'python-pip', 'python-virtualenv'],
      2.7    => ['python2', 'python2-pip', 'python2-virtualenv']
    },
  }
  $python_cmd = {
    'Archlinux' => {
      latest => {
        virtualenv_cmd => '/usr/bin/virtualenv',
        pip_cmd        => '/usr/bin/pip'
      },
      2.7    => {
        virtualenv_cmd => '/usr/bin/virtualenv2',
        pip_cmd        => '/usr/bin/pip2.7'
      }
    },
  }

  case $python_version {
    '2.7': {
      $packages = $python_packages[$::osfamily][2.7]
      $virtualenvcmd = $python_cmd[$::osfamily][2.7][virtualenv_cmd]
      $pipcmd = $python_cmd[$::osfamily][2.7][pip_cmd]
    }
    default: {
      $packages = $python_packages[$::osfamily][latest]
      $virtualenvcmd = $python_cmd[$::osfamily][latest][virtualenv_cmd]
      $pipcmd = $python_cmd[$::osfamily][latest][pip_cmd]
    }
  }

  package { $packages:
    ensure => present,
  }

  $dashboard_name = 'testing'
  # Exec to setup the virualenv in the tipboard users home
  exec { "tipboard-$python_virtualenv":
    command => "su - $tipboard_user -c '$virtualenvcmd $tipboard_home'",
    unless  => "test -f ${tipboard_home}/${virtualenv_source}",
    require => [
      Package[$packages],
      User[$tipboard_user]
    ],
  }

  # Exec to pip install tipboard
  exec { 'tipboard-setup':
    command => "su - $tipboard_user -c 'source ${tipboard_home}/${virtualenv_source} && ${tipboard_home}/bin/pip install tipboard'",
    unless  => "test -f ${tipboard_home}/bin/tipboard",
    require => Exec["tipboard-$python_virtualenv"],
  }

  # Exec to initialize tipboard
  exec { "tipboard-init-$dashboard_name":
    command => "su - $tipboard_user -c 'source ${tipboard_home}/${virtualenv_source} && ${tipboard_home}/bin/tipboard create_project $dashboard_name'",
    unless  => "test -d ${tipboard_home}/.tipboard",
    require => Exec['tipboard-setup'],
  }

  # Setup the systemd service file
  file { "/usr/lib/systemd/system/tipboard-$dashboard_name.service":
    ensure  => file,
    mode    => '0755',
    content => template('profile_tipboard/tipboard.service.erb'),
  }

  service { "tipboard-$dashboard_name":
    ensure  => running,
    require => [
      File["/usr/lib/systemd/system/tipboard-$dashboard_name.service"],
      Exec["tipboard-init-$dashboard_name"]
    ],
  }
}
