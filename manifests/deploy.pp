# install the avira.deploy upstart scripts and the avira.deploy package.

class puppetmaster::deploy {
    package { "python-avira.deploy.d":
        ensure => latest
    }

    service {"puppetbot":
        provider => 'upstart',
        ensure => running,
        require => Package["python-avira.deploy.d"]
    }
    
    package { "python-avira.deployplugin.cloudstack":
        ensure => latest
    }
}
