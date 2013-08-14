#
# Cookbook Name:: tripwire
# Recipe:: do_cron_disable
#
# Copyright 2013, Abine, Inc.
#
# All rights reserved - Do Not Redistribute
#

rightscale_marker :begin

tripwire_cron 'tripwire' do
  enable false
end

rightscale_marker :end
