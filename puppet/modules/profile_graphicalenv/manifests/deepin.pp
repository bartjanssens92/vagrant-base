#
#
#
class profile_graphicalenv::deepin () {
  include ::profile_graphicalenv::xorg
  include ::profile_graphicalenv::deepin::install
  class { '::profile_graphicalenv::xorg::xinit':
    to_start => 'xscreensaver &
xsetroot -cursor_name left_ptr &
exec startdde'
  }
}
