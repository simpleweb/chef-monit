#
# Cookbook Name:: monit
# Attributes:: default
#
# Author:: Phil Cohen <github@phlippers.net>
#
# Copyright 2011-2012, Phil Cohen
#


# How frequently the monit daemon polls for changes.
default["monit"]["polling_frequency"] = 20

# Use syslog for logging instead of a logfile.
default["monit"]["use_syslog"]        = true

# If not using syslog, the log file that monit will use.
default["monit"]["logfile"]           = "/var/log/monit.log"

# Email address that will be notified of events.
default["monit"]["alert_email"]       = "root@localhost"

# Enable the web interface and define credentials.
default["monit"]["web_interface"] = {
  :enable  => true,
  :port    => 2812,
  :address => "localhost",
  :allow   => ["localhost", "admin:b1gbr0th3r"]
}

# Email settings that will be used for notification of events.
default["monit"]["mail"] = {
  :hostname => "localhost",
  :port     => 25,
  :username => nil,
  :password => nil,
  :from     => "monit@$HOST",
  :subject  => "$SERVICE $EVENT at $DATE",
  :message  => "Monit $ACTION $SERVICE at $DATE on $HOST,\n\nDutifully,\nMonit",
  :tls      => false,
  :timeout  => 30
}

case node[:platform]
when "centos", "redhat", "fedora", "suse"
  default["monit"]["main_config_path"] = "/etc/monit.conf"
  default["monit"]["includes_dir"]     = "/etc/monit.d"
when "debian", "ubuntu"
  default["monit"]["main_config_path"] = "/etc/monit/monitrc"
  default["monit"]["includes_dir"]     = "/etc/monit/conf.d"
end
