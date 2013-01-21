class puppetmaster::setupapt {
    include stdlib

    class {'apt':
        always_apt_update => true,
        disable_keys => true,
        stage => 'setup'
    }
}
