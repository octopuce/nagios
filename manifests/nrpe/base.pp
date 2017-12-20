class nagios::nrpe::base {

    $nagios_nrpe_server_address = $nagios::nrpe::server_address
    $nagios_nrpe_allowed_hosts = $nagios::nrpe::allowed_hosts
    $nagios_nrpe_pid_file = $nagios::nrpe::nagios_nrpe_pid_file
    $nagios_plugin_dir = $nagios::nrpe::nagios_plugin_dir

    $nagios_nrpe_cfgdir = '/etc/nagios'
    if $processorcount == undef { $processorcount = 1 }
    
    package {   "nagios-nrpe-server": ensure => present;
        "nagios-plugins-basic": ensure => present;}
	if(  ! defined( Package["libwww-perl"] ) ){ 
	package { "libwww-perl": ensure => present}   # for check_apache
      }

    # Special-case lenny. the package doesn't exist
    if $lsbdistcodename != 'lenny' {
        package { "libnagios-plugin-perl": ensure => present; }
    }
    
    file { "$nagios_nrpe_cfgdir": 
      ensure => directory;
    }
    file { "$nagios_nrpe_cfgdir/nrpe.d": 
      ensure => directory,
      mode    => "655", owner   => root, group   => root,
      recurse => true,   # enable recursive directory management
      purge => true,   # purge all unmanaged junk
      force => true,   # also purge subdirs and links etc.
      notify => Service['nagios-nrpe-server'];
    }
    
    file { "$nagios_nrpe_cfgdir/nrpe.cfg":
      content => template('nagios/nrpe/nrpe.cfg'),
      owner => root, group => 0, mode => "644";
    }
    
    # default commands
#    nagios::nrpe::command { "basic_nrpe":
#        source => [ "puppet:///modules/site_nagios/configs/nrpe/nrpe_commands.${fqdn}.cfg",
#                    "puppet:///modules/site_nagios/configs/nrpe/nrpe_commands.cfg",
#                    "puppet:///modules/nagios/nrpe/nrpe_commands.cfg" ],
#    }
#    # the check for load should be customized for each server based on number
#    # of CPUs and the type of activity.
#    $warning_1_threshold = 7 * $processorcount
#    $warning_5_threshold = 6 * $processorcount
#    $warning_15_threshold = 5 * $processorcount
#    $critical_1_threshold = 10 * $processorcount
#    $critical_5_threshold = 9 * $processorcount
#    $critical_15_threshold = 8 * $processorcount
#    nagios::nrpe::command { "check_load":
#        command_line => "${nagios_plugin_dir}/check_load -w ${warning_1_threshold},${warning_5_threshold},${warning_15_threshold} -c ${critical_1_threshold},${critical_5_threshold},${critical_15_threshold}",
#    }

    service { 'nagios-nrpe-server':
      ensure    => running,
      enable    => true,
      pattern   => 'nrpe',
      hasstatus => true,
      hasrestart => true,
      subscribe => File["$nagios_nrpe_cfgdir/nrpe.cfg"],
      require   => Package['nagios-nrpe-server'],
    }
}
