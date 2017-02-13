# Class profile_graphicalenv
#
# Mainly a wrapper class to load some params and
# call the correct sub classes.
#
# Parameters:
#
#   environment:
#     Used to pick the graphical environment.
#     Defaults to: i3
#     Example:
#       profile_graphicalenv::environment: gnome
#
#   user:
#     The user to set the configuration files for.
#     This one is also used to execute the uglyyaourt exec in tools.pp
#     Default to: vagrant
#
#   group:
#     The group to set the configuration files for.
#     This one is also used to execute the uglyyaourt exec in tools.pp
#     Default to: vagrant
#
#   tools:
#     Hash to pass what tools are desired on the box.
#     These are mostly graphical tools.
#     For more info on how the hash needs to be used look in tools.pp
#
class profile_graphicalenv (
  $environment = 'i3',
  $user = 'vagrant',
  $group = 'vagrant',
  $tools = {}
) {
  # According to the environment, include the correct subclass
  case $environment {
    'i3'      : { include ::profile_graphicalenv::i3 }
    'deeping' : { include ::profile_graphicalenv::deeping }
    'gnome'   : { include ::profile_graphicalenv::gnome }
    default   : { include ::profile_graphicalenv::i3 }
  }
  # Setup the tools specified
  create_resources( ::profile_graphicalenv::tools, $tools )
} # class profile_graphicalenv
