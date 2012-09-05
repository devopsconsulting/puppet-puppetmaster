class puppetmaster::foremanrole {
    file {"/usr/share/foreman/app/views/hosts/_list.html.erb":
        source => 'puppet:///modules/puppetmaster/usr/share/foreman/app/views/hosts/_list.html.erb',
        ensure => file,
        replace => true,
        owner => 'foreman',
        group => 'foreman',
        mode => '0644',
        require => Package['foreman'],
        before => Class['foreman::service'],
    }
}