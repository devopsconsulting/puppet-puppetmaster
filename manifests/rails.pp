class puppetmaster::rails {
    package { "activerecord":
        provider => gem,
        ensure => "3.0.11",
        require => Class["ruby"],
    }
}
