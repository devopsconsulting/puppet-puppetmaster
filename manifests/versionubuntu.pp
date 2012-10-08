# last tested version : 2.7.19
class puppetmaster::versionubuntu {
    package {"puppetmaster-common":
        ensure => "2.7.19-1puppetlabs2",
    }

    package {"puppetmaster":
        require => Package["puppetmaster-common"],
        ensure => "2.7.19-1puppetlabs2",
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
