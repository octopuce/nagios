class nagios::command::nrpe {

  # this command runs a program $ARG1$ with arguments $ARG2$
  nagios_command {
    'check_nrpe':
       command_line => '/usr/lib/nagios/plugins/check_nrpe -H $HOSTADDRESS$ -c $ARG1$ -a $ARG2$'
  }

  # this command runs a program $ARG1$ with no arguments
  nagios_command {
    'check_nrpe_1arg':
       command_line => '/usr/lib/nagios/plugins/check_nrpe -H $HOSTADDRESS$ -c $ARG1$'
  }

  # this command runs a program $ARG1$ with timeout
  nagios_command {
    'check_nrpe_1arg_timeout':
       command_line => '/usr/lib/nagios/plugins/check_nrpe -H $HOSTADDRESS$ -c $ARG1$ -t $ARG2$'
  }

}
