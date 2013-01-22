class puppetmaster::mysqldb {    
    if $::osfamily {
        class { 'mysql::server':}
        
        class { 'mysql::ruby': }
    
        mysql::db { 'puppet':
          user     => 'puppet',
          password => 'teppup',
          host     => 'localhost',
          grant    => ['all'],
        }

        mysql::db { 'foreman':
          user     => 'foreman',
          password => 'namerof',
          host     => 'localhost',
          grant    => ['all'],
        }
    
        Class["mysql::server"] -> Class["mysql::ruby"] -> Class["puppetmaster::mysqldb"]

    }
}
