#
# Cookbook Name:: tripwire
# Definition:: tripwire_cron
#
# Copyright 2013, Abine, Inc.
#
# All rights reserved - Do Not Redistribute
#

define :tripwire_cron, :enable => true do
  if params[:enable]
    cron "tripwire_check" do
      minute "*/10"
      command "/opt/tripwire/sbin/tripwire --check"
    end
  else
    cron "tripwire_check" do
      action :delete
    end
  end
end
