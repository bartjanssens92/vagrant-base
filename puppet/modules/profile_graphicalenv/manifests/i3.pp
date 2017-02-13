# Class profile_graphicalenv::i3
#
# Main class to include all the dependencies
# for i3 to be up and running.
#
class profile_graphicalenv::i3 (
  $logdir = '/var/log/i3log',
) {
  include ::profile_graphicalenv::xorg
  include ::profile_graphicalenv::i3::install

  # Add a log dir for the i3 logs
  file { $logdir:
    ensure => directory,
    owner  => 'vagrant',
    mode   => '0666',
  }

  # Setup xinitrc
  class { '::profile_graphicalenv::xorg::xinit':
    user     => 'vagrant',
    require  => File[$logdir],
    to_start => 'xscreensaver &
xsetroot -cursor_name left_ptr &
exec i3 -V >> /var/log/i3log/i3log-$(date +\'%F-%k-%M-%S\') 2>&1',
  }
} # class profile_graphicalenv::i3
