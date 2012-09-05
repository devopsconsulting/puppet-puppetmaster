class puppetmaster::apacheports {
    case $::operatingsystem {
        Debian,Ubuntu: {
            file { "disable-port-eighty":
                path => "/etc/apache2/ports.conf",
                content => "Listen 443\nListen 81",
                replace => true,
                ensure => file,
                notify => Exec['reload-apache'],
                before => Class["apache::service"],
                require => Package["apache2"],
            }    
        }
    }
} 
