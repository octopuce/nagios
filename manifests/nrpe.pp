class nagios::nrpe (
  $server_address = '127.0.0.1',
  $allowed_hosts  = '127.0.0.1',
) {
    case $operatingsystem {
        'FreeBSD': {
            $nagios_nrpe_cfgdir = '/usr/local/etc'
            $nagios_nrpe_pid_file = '/var/spool/nagios/nrpe2.pid'
            $nagios_plugin_dir = '/usr/local/libexec/nagios'

            include nagios::nrpe::freebsd
        }
        'Debian','Ubuntu': {
            $nagios_nrpe_cfgdir = '/etc/nagios'
            $nagios_nrpe_pid_file = '/var/run/nagios/nrpe.pid'
            $nagios_plugin_dir = '/usr/lib/nagios/plugins'

            case $kernel {
                linux: { include nagios::nrpe::linux }
                default: { include nagios::nrpe::base }
            }
        }
        default: {
            $nagios_nrpe_cfgdir = '/etc/nagios'
            $nagios_nrpe_pid_file = '/var/run/nrpe.pid'
            $nagios_plugin_dir = '/usr/lib/nagios/plugins'

            case $kernel {
                linux: { include nagios::nrpe::linux }
                default: { include nagios::nrpe::base }
            }
        }
    }

}
