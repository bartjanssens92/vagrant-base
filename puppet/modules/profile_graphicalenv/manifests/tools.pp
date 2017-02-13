# Define profile_graphicalenv::tools:
#
# Wrapper define to install tools
#
# Hiera example
# profile_graphicalenv::tools:
#   terminalemulator:
#     package: terminator
#     config: /home/$user/.config/terminator/config
#   pidgin: {} # Empty hash to just install the package
#
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


