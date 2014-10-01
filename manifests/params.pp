# == Class: znc::params
#
# Just a bunch of defaults
#
class znc::params {

### Default values for the parameters of the main module class, init.pp

## ensure
  $ensure = present

## enable
  $enable = true

## autoupgrade
  $autoupgrade = false

### Configuration file handling and its defaults for the service

## Config File path
  $base_dir = $distribution ? {
    default => '/var/lib/znc/.znc'
  }
  $config_dir = $distribution ? {
    default => "${base_dir}/configs"
  }

  $config_file          = "${config_dir}/znc.conf"
  $config_file_template = "znc/znc.conf.erb"

## Whether or not to force constant znc config and restarts. True NOT RECOMMENDED
  $config_file_replace = false
  $owner               = znc
  $group               = znc
  $mode                = '0600'
  $dir_mode            = '0700'

## Config default values
  $anon_ip_limit        = '10'
  $connect_delay        = '5'
  $load_module          = 'webadmin'
  $max_buffer_size      = '500'
  $protect_web_sessions = true
  $ssl_cert_file        = '/var/lib/znc/.znc/znc.pem'
  $server_throttle      = '30'
  $skin                 = 'dark-clouds'
  $status_prefix        = '*'

### Package specific details
  $package = $::osfamily ? {
    /(RedHat|Debian)/ => [ 'znc' ],
  }
  $package_sasl_dependencies = $::osfamily ? {
    RedHat => ['cyrus-sasl'],
  }

### Service specific details
  $service = $::osfamily ? {
    /(RedHat|Debian)/ => [ 'znc' ],
  }

## service capabilities
  $service_hasstatus = $::osfamily ? {
    /(RedHat|Debian)/ => true,
  }

  $service_hasrestart = $::osfamily ? {
    /(RedHat|Debian)/ => true,
  }


}
