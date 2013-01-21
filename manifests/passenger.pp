class puppetmaster::passenger {
  include apache::ssl
  include apache::params
  include ::passenger

  $app_root = '/etc/puppet/rack'
  $conf_dir = '/etc/apache2/conf.d'
  $ssl_dir = '/var/lib/puppet/ssl'

  case $::operatingsystem {
    Debian,Ubuntu: {
      file { '/etc/default/puppetmaster':
        content => "START=no\n",
      }
    }
  }

  class {'apache':  } ->

  class {'apache::mod::passenger': } 

  file {'puppet_vhost':
    path    => "${conf_dir}/puppet.conf",
    content => template('puppetmaster/puppet-vhost.conf.erb'),
    mode    => '0644',
    notify  => Service['httpd'],
  } ->

  file {
    [$app_root, "${app_root}/public", "${app_root}/tmp"]:
      ensure => directory,
      owner  => 'puppet',
  } ->

  file {
    "${app_root}/config.ru":
      owner  => 'puppet',
      source => 'puppet:///modules/puppetmaster/config.ru',
      notify => Service['httpd']
  }

  # this is needed so passenger has the correct permissions
  file { 
      "/var/lib/puppet/reports":
      owner => 'puppet',
      mode => 640,
      ensure => "directory"
  }
  file { 
      "/var/log/puppet/http.log":
      owner => 'puppet',
      mode => 644,
      ensure => "file"
  }
}
