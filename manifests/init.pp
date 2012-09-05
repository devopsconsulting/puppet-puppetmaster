class puppetmaster {
    include puppetmaster::host
    include puppetmaster::version
    include puppetmaster::mysqldb
    include puppetmaster::rails
    Class["puppetmaster::host"] -> Class["puppetmaster::version"] -> Class["puppetmaster::mysqldb"] ->
    Class["puppetmaster::rails"]
}
