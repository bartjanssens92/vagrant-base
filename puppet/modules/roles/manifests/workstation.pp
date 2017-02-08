#
#
#
class roles::workstation () {
  include ::profile_graphicalenv::i3
  include ::profile_graphicalenv::tools
  include ::profile_base::tools
}
