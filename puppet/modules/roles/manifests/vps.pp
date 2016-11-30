#
# VPS role
# Node that does apache proxy to the internal bbqnetwork
# Also contains a openvpn client
#
class roles::vps () {

  include ::profile_base
  include ::profile_apache
  include ::profile_openvpn
  include ::tipboard

} # class roles::vps

