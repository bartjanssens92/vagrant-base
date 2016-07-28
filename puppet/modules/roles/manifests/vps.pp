#
# VPS role
# Node that does apache proxy to the internal bbqnetwork
#
class roles::vps () {

  include ::profile_base
  include ::profile_apache

} # class roles::vps

