class nagios::nrpe::base {

    if $nagios_nrpe_cfgdir == '' { $nagios_nrpe_cfgdir = '/etc/nagios' }
    if $processorcount == '' { $processorcount = 1 }
    
    package {   "nagios-nrpe-server": ensure => present;
        "nagios-plugins-basic": ensure => present;}
	if(  ! defined( Package["libwww-perl"] ) ){ 
	package { "libwww-perl": ensure => present}   # for check_apache
      }

    # Special-case lenny. the package doesn't exist
    if $lsbdistcodename != 'lenny' {
        package { "libnagios-plugin-perl": ensure => present; }
    }
    
    file { [ $nagios_nrpe_cfgdir, "$nagios_nrpe_cfgdir/nrpe.d" ]: 
  ensure => directory }
    
    if $nagios_nrpe_dont_blame == '' { $nagios_nrpe_dont_blame = 1 }
    file { "$nagios_nrpe_cfgdir/nrpe.cfg":
      content => template('nagios/nrpe/nrpe.cfg'),
      owner => root, group => 0, mode => 644;
    }
    
    
    service { 'nagios-nrpe-server':
      ensure    => running,
      enable    => true,
      pattern   => 'nrpe',
      hasstatus => false,
      subscribe => File["$nagios_nrpe_cfgdir/nrpe.cfg"],
      require   => Package['nagios-nrpe-server'],
    }
}
