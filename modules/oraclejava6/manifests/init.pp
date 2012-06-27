class oraclejava6 ($sourcebinary = "jdk-6u33-linux-x64.bin", $outputdir= "jdk1.6.0_33") {

  $required_packages = [
                        'augeas-lenses',
                        'augeas-tools',
                        ]
  package { $required_packages:
    ensure     => installed,
    before     => File["/opt"],
  }
  
  file { "/opt" :
    mode       => "0755",
    owner      => "root",
    ensure     => "directory",
  }

  file { "/opt/${sourcebinary}":
    mode       => "0755",
    owner      => 'root',
    group      => 'root',
    source     => "puppet:///modules/oraclejava6/${sourcebinary}",
    require    => File["/opt"],    
  }

  exec { "unpack ${sourcebinary}":
    cwd        => "/opt",
    command    => "/opt/${sourcebinary} -noregister",
    unless     => "ls /opt/${outputdir}",
    path       => "/usr/bin:/usr/sbin:/bin",
    require    => File["/opt/${sourcebinary}"],
  }


  file { "/usr/lib/jvm":
    mode       => "0755",
    owner      => "root",
    group      => "root",
    ensure     => "directory",
    require    => Exec["unpack ${sourcebinary}"],
  }

  file { "/usr/lib/jvm/${outputdir}" :
    ensure     => link,
    target     => "/opt/${outputdir}",
    force      => true,
    require    => File["/usr/lib/jvm"],
    
  }
  
  utility::alternatives::install { "install-java-alternatives":
    link      => "/usr/bin/java",
    name      => "java",
    path      => "/usr/lib/jvm/${outputdir}/bin/java",
    require   => File["/usr/lib/jvm/${outputdir}"],
  }

  utility::alternatives::install { "install-javac-alternatives":
    link     => "/usr/bin/javac",
    name     => "javac",
    path     => "/usr/lib/jvm/${outputdir}/bin/javac",
    require  => File["/usr/lib/jvm/${outputdir}"],
  }

  utility::alternatives::install { "install-javaws-alternatives":
    link     => "/usr/bin/javaws",
    name     => "javaws",
    path     => "/usr/lib/jvm/${outputdir}/bin/javaws",
    require  => File["/usr/lib/jvm/${outputdir}"],
  }
  
  augeas { "set-java-home":
    context   => "/files/etc/environment",
    changes   => ["set JAVA_HOME /usr/lib/jvm/${outputdir}",],
    require   => File["/usr/lib/jvm/${outputdir}"],
  }
}
