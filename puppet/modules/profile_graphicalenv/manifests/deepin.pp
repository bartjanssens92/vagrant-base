# Class profile_graphicalenv::deepin
#
# Main class that includes the things needed
# for deepin to be up and running.
#
class profile_graphicalenv::deepin () {
  # Xorg is needed
  include ::profile_graphicalenv::xorg
  include ::profile_graphicalenv::deepin::install

  # Setup xinitrc
  class { '::profile_graphicalenv::xorg::xinit':
    to_start => 'xscreensaver &
xsetroot -cursor_name left_ptr &
exec startdde'
  }
} # class profile_graphicalenv::deepin
