require 'ipaddr'
require 'puppet/util/ipcidr'

# based on the presentation of Thomas Uphill on PuppetConf 2013,
# "Building dynamic networks with puppet", Slide 37
def cidr(dev)
  network = Facter.value("network_#{dev}")
  netmask = Facter.value("netmask_#{dev}")
  if network && netmask
    cidr = Puppet::Util::IPCidr.new(network).mask(netmask).cidr
    Facter.add("cidr_#{dev}") do
      setcode do
        cidr
      end
    end
  end
end

# loop through the interfaces, defining the two facts for each
interfaces = Facter.value('interfaces').split(',')
interfaces.each do |eth|
  cidr(eth)
end
