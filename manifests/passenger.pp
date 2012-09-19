class puppetmaster::passenger {
  include apache::ssl
  include apache::params
  include ::passenger

  $app_root = '/etc/puppet/rack'
  $ssl_dir = '/var/lib/puppet/ssl'
  
  case $::operatingsystem {
    Debian,Ubuntu: {
      file { '/etc/default/puppetmaster':
        content => "START=no\n",
        #before  => Class['puppet::server::install']
      }
    }
  }

  file {'puppet_vhost':
    path    => "${apache::params::configdir}/puppet.conf",
    content => template('puppetmaster/puppet-vhost.conf.erb'),
    mode    => '0644',
    notify  => Exec['reload-apache'],
  }

  exec {'restart_puppet':
    command     => "/bin/touch ${app_root}/tmp/restart.txt",
    refreshonly => true,
    cwd         => $app_root,
    path        => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    require     => File["${app_root}/tmp"],
  }

  file {
    [$app_root, "${app_root}/public", "${app_root}/tmp"]:
      ensure => directory,
      owner  => 'puppet',
  }
  file {
    "${app_root}/config.ru":
      owner  => 'puppet',
      source => 'puppet:///modules/puppetmaster/config.ru',
      notify => Exec['restart_puppet'],
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
