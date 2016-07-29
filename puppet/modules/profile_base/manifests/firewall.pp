#
# Class to include if the firewall has to managed
#
class profile_base::firewall (
) {

  include ::firewall
  include ::profile_base::firewall::pre
  include ::profile_base::firewall::post

  firewall { '006 Allow inbound SSH on port 22':
    dport  => 22,
    proto  => 'tcp',
    action => 'accept',
    before => undef,
  }
}
