class nagios::plugins::contrib {

  # We don't install these by default as they have a crapton of dependencies.
  package { 'nagios-plugins-contrib':
    ensure => present,
  }

}

# EOF
