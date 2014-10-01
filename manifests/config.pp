# == Class: znc::config
#
# This class should only be called by the parent
#
# === Parameters
#
# See documentation for main class
#
class znc::config (
  $ensure,
  $anon_ip_limit,
  $connect_delay,
  $load_modules,
  $max_buffer_size,
  $protect_web_sessions,
  $ssl_cert_file,
  $server_throttle,
  $skin,
  $status_prefix,
) {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  include znc::params

  if ! ($ensure in [ present, absent ]) {
     fail('Only valid options are present or absent for $ensure')
  } else {
    $file_ensure = $ensure ? {
      present => file,
      absent  => absent,
    }
    $dir_ensure = $ensure ? {
      present => directory,
      absent  => absent,
    }
  }

  file { $znc::params::config_file:
    ensure  => $file_ensure,
    replace => $znc::params::config_file_replace,
    owner   => $znc::params::owner,
    group   => $znc::params::group,
    mode    => $znc::params::mode,
    content => template($znc::params::config_file_template),
    require => [ File[$znc::params::config_dir], Package[$znc::params::package] ],
    notify  => Service[$znc::params::service],
  }

  file { $znc::params::base_dir:
    ensure  => $dir_ensure,
    owner   => $znc::params::owner,
    group   => $znc::params::group,
    mode    => $znc::params::dirmode,
    require => Package[$znc::params::package],
  }

  file { $znc::params::config_dir:
    ensure  => $dir_ensure,
    owner   => $znc::params::owner,
    group   => $znc::params::group,
    mode    => $znc::params::dirmode,
    require => File[$znc::params::base_dir],
  }

}
