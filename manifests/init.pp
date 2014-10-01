# == Class: znc
#
# Configuring a basic instance of ZNC. Unfortunately the config is
# initial setup because ZNC then takes over its own config.
#
# For more information on the configuration options see the ZNC wiki
#
#   http://wiki.znc.in/Configuration
#
# === Parameters
#
# Document parameters here.
#
# [*ensure*]
#  String. Controls if the managed resources shall be <tt>present</tt> or
#  <tt>absent</tt>. If set to <tt>absent</tt>:
#  * The managed software packages are being uninstalled.
#  * Any traces of the packages will be purged as good as possible. This may
#    include existing configuration files. The exact behavior is provider
#    dependent. Q.v.:
#  * Puppet type reference: {package, "purgeable"}[http://j.mp/xbxmNP]
#  * {Puppet's package provider source code}[http://j.mp/wtVCaL]
#  * System modifications (if any) will be reverted as good as possible
#    (e.g. removal of created users, services, changed log settings, ...).
#  * This is thus destructive and should be used with care.
#  Defaults to <tt>present</tt>.
#
# [*enable*]
#  Bool/String. Controls if the managed service shall be running(<tt>true</tt>),
#  stopped(<tt>false</tt>), or <tt>manual</tt>. This affects the service state
#  at both boot and during runtime.  If set to <tt>manual</tt> Puppet will
#  ignore the state of the service.
#  Defaults to <tt>true</tt>.
#
# [*enable_sasl*]
#  Boolean. If enabled, ensures that the appropriate sofrware is installed.
#
# [*anon_ip_limit*]
#  Integer. Limit number of unidentified connections per IP.
#
# [*connect_delay*]
#  Integer. Time every connection will be delayed.
#
# [*load_modules*]
#  Array. Should contain a list of modules you want to load.
#  Format:
#    [ 'module <params>', 'module2 <params>', 'module3' ]
#
# [*max_buffer_size*]
#  Integer. Sets the global Max Buffer Size a user can have.
#
# [*protect_web_sessions*]
#  beats me :)
#
# [*ssl_cert_file*]
#  It's the TLS/SSL certificate file from which ZNC reads its server certificate.
#
# [*server_throttle*]
#  The time between two connect attempts to the same hostname.
#
# [*skin*]
#  String. Sets the global dfault theme.
#
# [*status_prefix*]
#  String. The prefix for the status and module queries.
#
#
# === Examples
#
#  include znc
#
# === Authors
#
# Greg Swift <gregswift@gmail.com>
#
# === Copyright
#
# Copyright 2014 Greg Swift
#
class znc (
  $ensure               = present,
  $enable               = $znc::params::enable,
  $enable_sasl          = false,
  $anon_ip_limit        = $znc::params::anon_ip_limit,
  $connect_delay        = $znc::params::connect_delay,
  $load_modules         = $znc::params::load_modules,
  $max_buffer_size      = $znc::params::max_buffer_size,
  $protect_web_sessions = $znc::params::protect_web_sessions,
  $ssl_cert_file        = $znc::params::ssl_cert_file,
  $server_throttle      = $znc::params::server_throttle,
  $skin                 = $znc::params::skin,
  $status_prefix        = $znc::params::status_prefix,
) inherits znc::params {

  class { 'znc::package':
    ensure      => $ensure,
    enable_sasl => $enable_sasl
  }
  class { 'znc::config':
    ensure               => $ensure,
    enable_sasl          => $enable_sasl,
    anon_ip_limit        => $anon_ip_limit,
    connect_delay        => $connect_delay,
    load_modules         => $load_modules,
    max_buffer_size      => $max_buffer_size,
    protect_web_sessions => $protect_web_sessions,
    ssl_cert_file        => $ssl_cert_files,
    server_throttle      => $service_throttle,
    skin                 => $skin,
    status_prefix        => $status_prefix,
  }
  class { 'znc::service':
    ensure => $ensure,
    enable => $enable,
  }

}
