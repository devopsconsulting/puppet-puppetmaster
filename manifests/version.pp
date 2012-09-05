# last tested version : 2.7.17
class puppetmaster::version {
    require puppet::version

    package {"puppetmaster":
        ensure => latest,
    }
}
