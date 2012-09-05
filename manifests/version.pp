# last tested version : 2.7.17
class puppetmaster::version {
    require puppet::version

    package {"puppetmaster":
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
