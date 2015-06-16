#
# Cookbook Name:: template-cookbook
# Recipe:: default
#
# Copyright 2015
#

directory "/etc/chef"
file "/etc/chef/client.rb"

include_recipe "openssh::default"
