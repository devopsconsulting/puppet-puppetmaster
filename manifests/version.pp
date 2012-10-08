# last tested version : 2.7.19
class puppetmaster::version {
    require puppet::version

    case $::operatingsystem {
        'Debian','Ubuntu': {
            include puppetmaster::versionubuntu
        }
        'Centos','Fedora': {
            include puppetmaster::versionfedora
        }
    }
}
