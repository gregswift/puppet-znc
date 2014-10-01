# == Class: znc::service
#
# Responsible for managing state of the ZNC service
#
class znc::service (
  $ensure,
  $enable,
) {

  include znc::params

### Logic

## set params: in operation
  if $ensure == present {
    $service_ensure = $enable ? {
      true  => running,
      false => stopped,
    }
    $service_enable = $enable

## set params: off
  } else {
    $service_ensure = stopped
    $service_enable = false
  }

## Debugging
  debug("\$service_ensure = '${service_ensure}'")
  debug("\$service_enable = '${service_enable}'")

### Manage actions

  service { $znc::params::service:
    ensure     => $service_ensure,
    enable     => $service_enable,
    hasstatus  => $znc::params::service_hasrestart,
    hasrestart => $znc::params::service_hasrestart,
    require    => Package[$znc::params::package],
    subscribe  => File[$znc::params::config_file]
  }
}
