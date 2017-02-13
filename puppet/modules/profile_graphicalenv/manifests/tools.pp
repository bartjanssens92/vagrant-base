# Define profile_graphicalenv::tools:
#
# Wrapper define to install tools.
#
# Parameters:
#
#   toolname: ( String )
#     Name of the tool to install or uniq name of the collection
#     of tools to install.
#     Defaults to: $title
#
#   package: ( Array )
#     List of packages to install.
#     Defaults to: $title
#
#   configfile: ( Sting )
#     Path to where to put the configfile, the template that is used
#     should be in profile_graphicalenv/templates/tools/$toolname.
#     When set to undef, assumes that there is no configfile.
#     Defaults to: undef
#
#   ensure: ( String )
#     State of the package to be in.
#     Defaults to: present.
#
#   uglyyaourt: ( Boolean )
#     Flag to set if the yaourt exec should be used.
#     This is needed in certain cases where the package resource
#     comes up short. Might be unneeded as it get's inproved.
#     Defaults to: false
#
# Hiera example
# profile_graphicalenv::tools:
#   # Installing terminatior ans setting the config file.
#   terminator:
#     configfile: /home/vagrant/.config/terminator/config
#   # Empty hash for tools that just need to be installed
#   chromium: {}
#   keepass: {}
#   pidgin: {}
#   # The packages below have the 'root' issue when building
#   # ==> workstation: ==> ERROR: Running makepkg as root is not allowed as it can cause permanent,
#   # ==> workstation: catastrophic damage to your system.
#   # That why there is an ugly exec here
#   remmina:
#     uglyyaourt: True
#     package:
#       remmina
#       remmina-plugin-rdesktop
#   spotify:
#     uglyyaourt: True
#   # Also needs a shell to be installed as it uses tput to get information
#   # tput: terminal attributes: No such device or address
#   libreoffice:
#     uglyyaourt: True
#     package:
#       libreoffice-fresh
#       libreoffice-fresh-nl # Dutch language pack for LibreOffice Fresh

define profile_graphicalenv::tools (
  $toolname   = $title,
  $package    = $title, # Default to title name as package name
  $configfile = undef,
  $ensure     = 'present',
  $uglyyaourt = false,
) {
  # ==> workstation: ==> ERROR: Running makepkg as root is not allowed as it can cause permanent,
  # ==> workstation: catastrophic damage to your system.
  # That why the use there is an ugly yaourt exec here
  if $uglyyaourt {
    exec { "Using yaourt cmd to install ${package}":
      command => "/usr/bin/yaourt --noconfirm --needed --noprogressbar -Sy ${package}",
      user    => $::profile_graphicalenv::user,
      group   => $::profile_graphicalenv::group,
      unless  => "/usr/bin/yaourt -Q ${package}",
    }
  } else {
    # Install the needed package
    package { $package:
      ensure => $ensure,
    }
  } # if $uglyyaourt

  # If there is no configfile
  if $configfile {
    # If there is a configfile make sure it exists
    # exec cuz of puppet not making parent dirs
    exec { "Creating directories:' $configfile'":
      path    => '/usr/bin:/usr/sbin:/bin',
      command => "mkdir -p $( dirname $configfile )",
      unless  => "test -d $( dirname $configfile )",
      user    => $::profile_graphicalenv::user,
      group   => $::profile_graphicalenv::group,
    }

    # If there is a template, make sure the configfile has that content
    # To ensure no duplicate stuff, dont' prefix this one
    file { $configfile:
      ensure  => file,
      content => template("profile_graphicalenv/tools/$toolname.erb"),
      owner   => $::profile_graphicalenv::user,
      group   => $::profile_graphicalenv::group,
      require => Package[$package],
    }
  } # if $configfile
} # define profile_graphicalenv::tools
