#
# Cookbook Name:: tripwire
# Recipe:: default
#
# Copyright 2013, Abine, Inc.
#
# All rights reserved - Do Not Redistribute
#
rightscale_marker :begin

package "tripwire" do
  action :install
end

log "Remove old keys and generate new ones"
file "#{node[:tripwire][:configdir]}/site.key" do
  action :delete
end
file "#{node[:tripwire][:configdir]}/#{node[:hostname]}-local.key" do
  action :delete
end

execute "generate keys" do
  cwd node[:tripwire][:configdir]
  command "twadmin --generate-keys -P #{node[:tripwire][:localpass]} -Q #{node[:tripwire][:sitepass]} -L #{node[:hostname]}-local.key -S site.key"
  creates "#{node[:tripwire][:configdir]}/site.key"
end

log "Remove old config and generate new ones"
file "#{node[:tripwire][:configdir]}/tw.cfg" do
  action :delete
end
file "#{node[:tripwire][:configdir]}/tw.pol" do
  action :delete
end

execute "modify config" do
  cwd node[:tripwire][:configdir]
  command "sed -i -e '/MAILNOVIOLATIONS/s/true/false/' twcfg.txt"
end

execute "sign config" do
  cwd node[:tripwire][:configdir]
  command "twadmin --create-cfgfile -c tw.cfg -Q #{node[:tripwire][:sitepass]} -S site.key twcfg.txt"
  creates "#{node[:tripwire][:configdir]}/tw.cfg"
end

log "Prepare database and policy"

cookbook_file "#{node[:tripwire][:configdir]}/twpol.txt" do
  source 'twpol.txt'
end

execute "Prepare policy" do
  command "twadmin --create-polfile -c tw.cfg -Q #{node[:tripwire][:sitepass]} -S site.key twpol.txt"
  cwd node[:tripwire][:configdir]
  creates "#{node[:tripwire][:configdir]}/tw.pol"
end

execute "init_tripwire_db" do
  command "tripwire --init -P #{node[:tripwire][:localpass]}"
end

node[:tripwire][:enabled] = true

rightscale_marker :end
