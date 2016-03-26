define nagios::nrpe::command (
    $ensure = present,
    $command_line = '',
    $source = '' )
{

  if (!defined(Class["nagios::nrpe::base"])) {
    require nagios::nrpe::base
  }
    
    if ($command_line == '' and $source == '') {
        fail ( "Either one of 'command_line' or 'source' must be given to nagios::nrpe::command." )
    }

    if $nagios_nrpe_cfg_dir == undef and $nagios::nrpe::base::nagios_nrpe_cfgdir {
        $nagios_nrpe_cfgdir = $nagios::nrpe::base::nagios_nrpe_cfgdir
    }
    if $nagios_nrpe_cfg_dir == undef and $nagios::nrpe::base::nagios_nrpe_cfgdir == undef {
        $nagios_nrpe_cfgdir = "/etc/nagios"
    }

    file { "${nagios_nrpe_cfgdir}/nrpe.d/${name}_command.cfg":
                    ensure => $ensure,
                    mode => "644", owner => root, group => 0,
                    notify => Service['nagios-nrpe-server'],
                    require => File["${nagios_nrpe_cfgdir}/nrpe.d"],
    }

    case $source {
        '': {
             File["${nagios_nrpe_cfgdir}/nrpe.d/${name}_command.cfg"] {
                content => template( "nagios/nrpe/nrpe_command.erb" ),
            }
        }
        default: {
            File["${nagios_nrpe_cfgdir}/nrpe.d/${name}_command.cfg"] {
                source => $source,
            }
        }
    }
}
