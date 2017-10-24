class nagios::nrpe::linux {

  include nagios::nrpe::base

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

