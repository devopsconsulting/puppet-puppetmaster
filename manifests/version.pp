# last tested version : 2.7.19
class puppetmaster::version {
    require puppet::version

    case $::operatingsystem {
        'Debian','Ubuntu': {
            $puppetmaster_package = "puppetmaster"
        }
        'Centos','Fedora': {
            $puppetmaster_package = "puppet-server"
        }
    }

    package {"puppetmaster-common":
        ensure => "2.7.19-1puppetlabs2",
    }

    package {$puppetmaster_package:
        case $::operatingsystem {
            'Debian','Ubuntu': {
               require => Package["puppetmaster-common"],
               ensure => "2.7.19-1puppetlabs2",
            }
            'Centos','Fedora': {
               ensure => "latest",
            }
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
