#
# Class to define all the post rules
# aka drop *
#
class profile_base::firewall::post () {
  firewall { '999 drop all':
    proto  => 'all',
    action => 'drop',
    before => undef,
  }
}
