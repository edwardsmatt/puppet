puppet-googlechrome
===================

Puppet module for installing Google Chrome Web Browser on Ubuntu.

Usage
=====

How To Get it:

    sudo git clone git@github.com:edwardsmatt/puppet-googlechrome.git /etc/puppet/modules/googlechrome
    
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