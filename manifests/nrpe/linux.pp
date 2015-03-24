class nagios::nrpe::linux inherits nagios::nrpe::base {

    package {
        "nagios-plugins-standard": ensure => present;
    }

}
