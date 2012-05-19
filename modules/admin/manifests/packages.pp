class admin::packages {

  Exec {
    path => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/X11R6/bin',
  }
  
  include repositories, packages
  
  exec { 'apt-get -q update':
    require  => Class['repositories'],
    before   => Class['packages'],
  }
  
  class packages {
    $base_packages = [
                      'openssh-server',
                      'gnome-shell',
                      'emacs23-nox',
                      'puppet-el',
                      'easytag',
                      'ack-grep',
                      'freemind',
                      'gufw',
                      'ubuntu-restricted-extras',
                      'vlc',
                      'gtk-recordmydesktop',
                      'git',
                      'gitk',
                      'tree',
                      'cheese',
                      'cheese-common',
                      'samba',
                      'shutter',
                      'virtualbox',
                      'ubuntu-tweak',
                      ]
    
    package { $base_packages:
      ensure => installed,
    }
  }

  class repositories {

    exec { 'install-virtualbox-repo':
      command  => 'wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | apt-key add -',
    }
    
    exec { 'add-ubuntutweak-ppa':
      command  => 'add-apt-repository ppa:tualatrix/ppa',
    }

    file { '/etc/apt/sources.list.d/partner.list':
      content  => "deb http://archive.canonical.com/ubuntu $lsbdistcodename partner\ndeb-src http://archive.canonical.com/ubuntu $lsbdistcodename partner",
    }
  }
}
