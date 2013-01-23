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

    # execute the migration directly after the creation of the db, otherwise it will fail
    exec { "migrate-db":
         command => "/bin/su - foreman -s /bin/bash -c /usr/share/foreman/extras/dbmigrate",
         cwd => "/usr/share/foreman/",
    } ->

    # this patch will show the role fact of the machine
   file {"/usr/share/foreman/app/views/hosts/_list.html.erb":
        source => 'puppet:///modules/puppetmaster/usr/share/foreman/app/views/hosts/_list.html.erb',
        ensure => file,
        replace => true,
        owner => 'foreman',
        group => 'foreman',
        mode => '0644',
    } ->

    # make sure the report get's into foreman
   file {"/usr/lib/ruby/1.8/puppet/reports/foreman.rb":
        source => 'puppet:///modules/puppetmaster/foreman.rb',
        ensure => file,
        replace => true,
        mode => '0644',
    } ->

    file {'foreman_vhost':
        path    => "${conf_dir}/foreman.conf",
        content => template('puppetmaster/foreman-vhost.conf.erb'),
        mode    => '0644',
        notify => Service["httpd"]
    }
}
