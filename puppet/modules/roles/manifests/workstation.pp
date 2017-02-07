#
#
#
class roles::workstation () {
  include ::profile_graphicalenv::xorg
  include ::profile_graphicalenv::gnome
  include ::profile_graphicalenv::tools
  #include ::profile_base::tools
}
