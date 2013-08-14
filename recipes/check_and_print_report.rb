#
# Cookbook Name:: tripwire
# Recipe:: check_and_print_report
#
# Copyright 2013, Abine, Inc.
#
# All rights reserved - Do Not Redistribute
#

rightscale_marker :begin

execute "tripwire_check" do
  command "tripwire --check"
end

rightscale_marker :end
