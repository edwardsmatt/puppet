puppet-ufw
==========

UFW Puppet Configuration Module.

Currently only allow and limit are supported. Reject and Deny will be implemented shortly.

Usage
=====

Allow Subnet:

    ufw::rule {"allow localsubnet":
      rule  => 'allow',
      from  => '192.168.0.0/24',
    }

Limit Port:

    ufw::rule {"limit ssh":
      rule  => 'limit',
      port  => '22',
    }

Allow Port:

    ufw::rule {'allow transmission port':
      rule  => 'allow',
      port  => '51413',
    }