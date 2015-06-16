#
# Base SSH configuration
#
default["openssh"]["server"]["use_dns"]        = "no"

default['openssh']['server']['permit_user_environment']       = "yes"

#
# Tighten authentication methods
#
default["openssh"]["server"]["password_authentication"]    = "no"
default["openssh"]["server"]["permit_root_login"]          = "no"

#
# Allow forwarding over SSH connections
#
default["openssh"]["server"]["x11_forwarding"]          = "yes"
default["openssh"]["server"]["subsystem"]               = "sftp /usr/libexec/openssh/sftp-server"
