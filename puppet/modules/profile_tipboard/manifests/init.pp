#
#
#
class profile_tipboard (
  $tipboard_user = 'tipboard',
  $tipboard_group = 'tipboard',
  $tipboard_home = '/opt/tipboard',
) {

  # Create the tipboard user and group
  group { $tipboard_group:
    ensure => present,
    system => true,
  }

  user { $tipboard_user:
    ensure  => present,
    home    => $tipboard_home,
    groups  => $tipboard_group,
    system  => true,
    require => Group[$tipboard_group],
  }

  # Setup a new virtualenv for tipboard
  python::virtualenv { $tipboard_home:
    ensure     => present,
    version    => '2.7',
    systempkgs => false,
    owner      => $tipboard_user,
    group      => $tipboard_group,
    require    => User['tipboard'],
  }

}
