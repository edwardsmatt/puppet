class maven3 ($mvnbin = "apache-maven-3.0.4-bin.tar.gz", $mvnurl = "http://apache.mirror.uber.com.au/maven/binaries/apache-maven-3.0.4-bin.tar.gz") {

  include oraclejava6
  
  exec {"wget -q $mvnurl":
    cwd     => '/opt',
    creates => '/opt/apache-maven-3.0.4-bin.tar.gz',
    before  => Exec["tar xvfz $mvnbin"],
  }

  exec {"tar xvfz $mvnbin":
    cwd     => '/opt',
    creates => '/opt/apache-maven-3.0.4',
    before  => File["/usr/lib/mvn"],
  }

  
  file { "/usr/lib/mvn":
    mode       => "0755",
    owner      => "root",
    group      => "root",
    ensure     => "directory",
    before     => File["/usr/lib/mvn/apache-maven-3.0.4"],
  }

  
  file { "/usr/lib/mvn/apache-maven-3.0.4" :
    ensure     => link,
    target     => "/opt/apache-maven-3.0.4",
    force      => true,
  }

  utility::alternatives::install { "install mvn alternatives":
    link      => "/usr/bin/mvn",
    name      => "mvn",
    path      => "/usr/lib/mvn/apache-maven-3.0.4/bin/mvn",
    require   => File["/usr/lib/mvn/apache-maven-3.0.4"],
  }

   augeas { "set-m2-home":
    context   => "/files/etc/environment",
    changes   => ["set M2_HOME /usr/lib/mvn/apache-maven-3.0.4",],
    require   => File["/usr/lib/mvn/apache-maven-3.0.4"],
  }
}
