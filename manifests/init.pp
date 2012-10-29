class puppetmaster {
    include puppetmaster::host
    include puppetmaster::version
    include puppetmaster::mysqldb
    include puppetmaster::rails
    include puppetmaster::passenger
    include puppetmaster::deploy
    Class["puppetmaster::host"] -> Class["puppetmaster::version"] -> Class["puppetmaster::mysqldb"] ->
    Class["puppetmaster::rails"] -> Class["puppetmaster::passenger"] -> Class["puppetmaster::deploy"]
}
