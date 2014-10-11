#!/usr/bin/env rspec
require 'spec_helper'

describe 'cidr_facts' do
  describe 'cidr_fact' do
    before do
      Facter.clear
      Facter.fact(:kernel).stubs(:value).returns('linux')
      Facter.fact(:interfaces).stubs(:value).returns('eth0')
      Facter.fact(:network_eth0).stubs(:value).returns('172.16.16.2')
      Facter.fact(:netmask_eth0).stubs(:value).returns('255.255.255.0')
    end
    it "should be of correct CIDR notation" do
      Facter.fact(:cidr_eth0).value.should == '172.16.16.0/24'
    end
  end
end
