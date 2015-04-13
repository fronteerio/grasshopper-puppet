class ghservice::postgresql {

    class { 'postgresql::server': }
    class { 'postgresql::server::contrib': }

    $dbname = hiera('postgresql_db_name')
    $user = hiera('postgresql_user')
    $pass = hiera('postgresql_pass')

    postgresql::server::db { "$dbname":
        user     => "$user",
        password => postgresql_password("$user", "$password"),
    } ->
    exec { 'enable pg_trgm':
        command => "sudo -u postgres psql $dbname -c 'CREATE EXTENSION IF NOT EXISTS pg_trgm'"
    }
}
