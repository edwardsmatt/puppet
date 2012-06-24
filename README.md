puppet
======

This repository contains some reusable puppet modules that I use on a regular basis.


modules/googlechrome
===================

Puppet module for installing Google Chrome Web Browser on Ubuntu.

Usage
=====

    
For Example:

    someone@somewhere:~$ sudo git clone git@github.com:edwardsmatt/puppet-googlechrome.git /etc/puppet/modules/googlechrome
    Cloning into '/etc/puppet/modules/googlechrome'...


The `googlechrome` class uses the following defaults:

    $path='/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/X11R6/bin', 
    $destFile  ='google-chrome-stable_current_amd64.deb', 
    $sourceURL ='https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb'


The most simple usage is using these defaults. For Example on a simple node:

    node someNodeThatHasChrome {
      include googlechrome
    }
    

I haven't tested the following, but to install the 32-bit version of google-chrome you could use:

    node someNodeThatHas32BitChrome {
      class { "googlechrome":
        destFile  => 'google-chrome-stable_current_i386.deb',
        sourceURL => 'https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb',
      }
    }
    

modules/ufw
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
    


modules/virtualbox
=================

Puppet Module for installing Virtualbox.

Currently only supports Debian-Like Systems:
* Debian
* Ubuntu