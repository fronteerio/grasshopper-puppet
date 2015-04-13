class ghservice::grasshopper {
    include ::ghservice::deps::common
    include ::ghservice::deps::nodejs
    include ::ghservice::ui

    Class['::ghservice::deps::common']  -> Class['::grasshopper']
    Class['::ghservice::deps::nodejs']  -> Class['::grasshopper']
    Class['::ui']                       -> Class['::grasshopper']

    $install_method = hiera('app_install_method', 'git')
    $install_config = hiera('app_install_config', {
        source => 'https://github.com/CUL-DigitalServices/grasshopper',
        revision => 'master'
    })

    class { '::grasshopper':
        app_root_dir                  => hiera('app_root_dir'),

        install_method                => $install_method,
        install_config                => $install_config,

        config_db_name                => hiera('postgresql_db_name'),
        config_db_user                => hiera('postgresql_user'),
        config_db_pass                => hiera('postgresql_pass'),
        config_db_host                => hiera('postgresql_host'),
        config_db_port                => hiera('postgresql_port'),

        os_user                       => hiera('app_os_user'),
        os_group                      => hiera('app_os_group'),

        config_cookie_secret          => hiera('app_cookie_secret'),
        config_servers_admin_host     => hiera('admin_hostname'),
        config_ui_path                => hiera('app_ui_path', '/opt/grasshopper-ui')
    }
}
