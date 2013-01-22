class puppetmaster::foremanrepo { 
    apt::source {"foreman":
        location => 'http://deb.theforeman.org/',
        release => 'precise',
        repos => 'stable',
        key => 'E775FF07',
        key_source => 'http://deb.theforeman.org/foreman.asc',
        include_src => false,
    }
}