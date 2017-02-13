# Class profile_graphicalenv::xorg
#
# Main class to setup Xorg
#
class profile_graphicalenv::xorg () {
  # Install the required packages
  include ::profile_graphicalenv::xorg::install
  # Setup the config
} # class profile_graphicalenv::xorg
