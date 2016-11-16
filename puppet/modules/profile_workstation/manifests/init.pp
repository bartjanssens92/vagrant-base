#
# Class profile_workstation
#
# Goal of this class is to setup a node with:
# - needed packages for working
# - gnome / graphical env
# - config of tools
# Stuff that needs to be managed:
# Graphic env
# - gnome
# Applications
# - pidgin
# - browsers
# - virtualbox / libvirt
# - vagrant
# - packer
# - vim
# - git
# - syncthing
# - keepass
# Config
# - ssh config -> git repo ?

class profile_workstation () {
  include ::gnome
  #include ::applications
}
