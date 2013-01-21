class puppetmaster {
    class {"puppetmaster::host": } -> 
    class {"puppetmaster::version": } ->
    class {"puppetmaster::mysqldb": } ->
    class {"puppetmaster::rails": } -> 
    class {"puppetmaster::passenger": } -> 
    class {"puppetmaster::deploy": }
}
