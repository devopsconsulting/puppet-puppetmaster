# last tested version : 2.7.17
class puppetmaster::version {
    require puppet::version

    case $::operatingsystem {
        'Debian','Ubuntu': {
            $puppetmaster_package = "puppermaster"
        }
        'Centos','Fedora': {
            $puppetmaster_package = "puppet-server"
        }
    }

    package {$puppetmaster_package:
        ensure => latest,
    }

    package {"misc-pierrot":
        ensure => latest,
        notify => Exec["pierrot-setup"],
    }

    exec {"pierrot-setup":
        command => "/usr/lib/pierrot/setup-puppetmaster.sh",
        refreshonly => true,
        timeout => 0,
    }
}
