#
#
#
class profile_graphicalenv (
  $environment = 'i3',
  $user = 'vagrant',
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
}


