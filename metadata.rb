name             "tripwire"
maintainer       "Abine, Inc."
maintainer_email "cloud@abine.com"
license          "All rights reserved"
description      "Installs/Configures Open Source Tripwire"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

depends "rightscale"

recipe "tripwire::default", "Set up Open Source Tripwire"
recipe "tripwire::check_and_print_report", "Run a Tripwire check, saving the report information to stdout"
recipe "tripwire::do_cron_enable", "Enable periodic (every 10 minutes) running of Tripwire check"
recipe "tripwire::do_cron_disable", "Disable periodic running of Tripwire check"

attribute "tripwire/localpass",
  :display_name => "Tripwire Local Password",
  :description => "Tripwire Local Password. This is used for maintaining the local database",
  :required => "required",
  :recipes => ["tripwire::default"]

attribute "tripwire/sitepass",
  :display_name => "Tripwire Site Password",
  :description => "Tripwire Site Password. This is used for maintaining the policy files and signing the configuration file",
  :required => "required",
  :recipes => ["tripwire::default"]
