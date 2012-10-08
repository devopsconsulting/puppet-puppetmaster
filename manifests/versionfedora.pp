# last tested version : 2.7.19
class puppetmaster::versionfedora {

    package {"puppet-server":
        ensure => "latest",
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
