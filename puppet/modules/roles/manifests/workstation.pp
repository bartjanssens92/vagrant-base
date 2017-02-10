#
#
#
class roles::workstation () {
  include ::profile_graphicalenv
  include ::profile_base::tools
}
