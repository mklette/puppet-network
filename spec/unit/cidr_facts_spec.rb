#!/usr/bin/env rspec
require 'spec_helper'

describe 'cidr_facts' do
  describe 'cidr_fact' do
    before do
      Facter.clear
      # This works
      Facter.fact(:interfaces).stubs(:value).returns('eth0')
      # while this don't. Tests fail as Facter lookup returns nil and in turns
      # Puppet::Utils::IPCidr.new() throws exception. Do I really need to use
      # something like Facter::Util::Resolution instead?
      Facter.fact(:network_eth0).stubs(:value).returns('10.0.0.0')
      Facter.fact(:netmask_eth0).stubs(:value).returns('255.0.0.0')
    end
    it "should be correct CIDR notation" do
      Facter.fact(:cidr_eth0).value.should == '10.0.0.0/8'
    end
  end
end
