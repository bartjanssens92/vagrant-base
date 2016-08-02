#
# Hornetmq role
# Node that has a non-clusterd hornetmq
# Might make a profile that is able to setup cluster later.
#
class roles::hornetmq () {

  include ::profile_base
  include ::profile_hornetmq

} # class roles::hornetmq

