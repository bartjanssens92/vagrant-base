# Class profile_graphicalenv::gnome
#
# Main class to include all the dependencies to
# get Gnome up and running.
#
class profile_graphicalenv::gnome () {
  # Can also be done on wayland but,
  # most users still want Xorg.
  include ::profile_graphicalenv::xorg
  include ::profile_graphicalenv::gnome::install
} # class profile_graphicalenv::gnome
