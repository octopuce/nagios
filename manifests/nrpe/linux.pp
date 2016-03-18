class nagios::nrpe::linux inherits nagios::nrpe::base {

  if $lsbdistcodename == "jessie" {
    
    package {
      "nagios-plugins-standard": ensure => purged;
      "monitoring-plugins-standard": ensure => present;
    }
    
  } else {
    
    package {
      "nagios-plugins-standard": ensure => present;
    }
  }
  
}

