#
#
#
class profile_graphicalenv::gnome () {
  include ::profile_graphicalenv::xorg
  include ::profile_graphicalenv::gnome::install
}
