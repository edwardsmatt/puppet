class mysql::server($root_password) {
  package {'mysql-server': ensure => installed ,}

  service {'mysql':
    enable   => true,
    ensure   => running,
    require  => Package['mysql-server'],
  }

  file {'/etc/mysql/my.cnf':
    owner   => 'mysql',
    group   => 'mysql',
    source  => 'puppet:///modules/mysql/my.cnf',
    notify  => Service['mysql'],
    require => Package['mysql-server'],
  }

  exec {"mysqladmin -uroot password ${root_password}":
    unless  => "mysqladmin -uroot -p${root_password} status",
    require => Service['mysql'],
  }

  define db ($root_password, $user, $password) {
        
    class {"mysql::server":
      root_password => "${root_password}",
    }

    exec { "mysql -uroot -p${root_password} -e \"create user ${user}@localhost identified by '$password'; create database ${name}; grant all on ${name}.* to ${user}@localhost identified by '$password'; flush privileges;\"":
      unless => "mysql -u${user} -p${password} ${name}",
      require => Service['mysql'],
    }
  }
}
