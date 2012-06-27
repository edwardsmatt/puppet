class grails ($version = "2.0.4" ) {

  include oraclejava6
  
  $zipfile  = "grails-${version}.zip"
  $url      = "http://dist.springframework.org.s3.amazonaws.com/release/GRAILS/${zipfile}"

  exec {"wget -q $url":
    cwd     => '/opt',
    creates => "/opt/grails-${version}.zip",
    before  => Exec["unzip ${zipfile}"],
  }

  exec {"unzip ${zipfile}":
    cwd     => '/opt',
    creates => "/opt/grails-${version}",
    before  => File["/usr/lib/grails"],
  }
  
  file { "/usr/lib/grails":
    mode       => "0755",
    owner      => "root",
    group      => "root",
    ensure     => "directory",
    before     => File["/usr/lib/grails/grails-${version}"],
  }

  
  file { "/usr/lib/grails/grails-${version}" :
    ensure     => link,
    target     => "/opt/grails-${version}",
    force      => true,
  }

  utility::alternatives::install { "install-grails-alternatives":
    link      => "/usr/bin/grails",
    name      => "grails",
    path      => "/usr/lib/grails/grails-${version}/bin/grails",
    require   => File["/usr/lib/grails/grails-${version}"],
  }

  utility::alternatives::install { "install-startGrails-alternatives":
    link      => "/usr/bin/startGrails",
    name      => "startGrails",
    path      => "/usr/lib/grails/grails-${version}/bin/startGrails",
    require   => File["/usr/lib/grails/grails-${version}"],
  }

   augeas { "set-grails-home":
    context   => "/files/etc/environment",
    changes   => ["set GRAILS_HOME /opt/grails-${version}",],
  }
}
