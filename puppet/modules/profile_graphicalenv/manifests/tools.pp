#
#
#
class profile_graphicalenv::tools (
  $tools = ['terminator', 'chromium','keepass'],
) {
  package { $tools:
    ensure => present,
  }
} # class profile_graphicalenv::tools
