#
# Cookbook Name:: tripwire
# Recipe:: do_cron_enable
#
# Copyright 2013, Abine, Inc.
#
# All rights reserved - Do Not Redistribute
#

rightscale_marker :begin

execute "tripwire_check" do
  command "tripwire --check"
end

tripwire_cron 'tripwire' do
  enable true
end

rightscale_marker :end
