define ufw::rule($rule, $from='', $port='') {

  case $rule {
    "allow" : {
      if $port == '' {
        ufw::allow::host {"${from}": }
        } elsif $from == '' {
        ufw::allow::service {"${port}":}
        } else {
        fail('Set either $from or $port, not both')
        }
    }
    "limit":{
      if $port == '' {
        ufw::limit::host {"${from}":}
        } elsif $from == '' {
        ufw::limit::service {"${port}":}
        } else {
        fail('Set either $from or $port, not both')
        }
    }
    "reject": {
      notice ("reject is not implemented yet...")
    }
    "deny": {
      notice ("deny is not implemented yet...")
    }
  }
}
