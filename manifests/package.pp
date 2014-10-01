# == Class: znc::package
#
# Responsible for installing the software for ZNC
#
# === Parameters
#
#
# === Examples
#
#  class { znc::package:
#    enable_sasl => true,
#  }
#
class znc::package (
  $ensure,
  $enable_sasl   = false,
) {

  include znc::params

  if $enable_sasl {
    package { $znc::params::package_sasl_dependencies:
      ensure => $ensure,
      before => Package[$znc::params::package],
    }
  }

  package { $znc::params::package:
    ensure => $ensure,
  }


}
