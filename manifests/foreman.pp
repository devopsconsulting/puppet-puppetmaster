class puppetmaster::foreman { 
    include apache
    $conf_dir = '/etc/apache2/conf.d'

    package {'foreman-mysql':
        ensure => "installed",
    } ->

    file { "/etc/foreman/database.yml":
        source => "puppet:///modules/puppetmaster/database.yml",
        mode => "755",
    } ->

    exec { "migrate-db":
         command => "/bin/su - foreman -s /bin/bash -c /usr/share/foreman/extras/dbmigrate",
         cwd => "/usr/share/foreman/",
    } ->

   file {"/usr/share/foreman/app/views/hosts/_list.html.erb":
        source => 'puppet:///puppetmaster/usr/share/foreman/app/views/hosts/_list.html.erb',
        ensure => file,
        replace => true,
        owner => 'foreman',
        group => 'foreman',
        mode => '0644',
    } ->

    file {'foreman_vhost':
        path    => "${conf_dir}/foreman.conf",
        content => template('puppetmaster/foreman-vhost.conf.erb'),
        mode    => '0644',
        notify => Service["httpd"]
    }
}
