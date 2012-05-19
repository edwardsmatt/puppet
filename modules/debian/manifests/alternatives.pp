define debian::alternatives::install($link, $name, $path, $priority = "1") {
  exec { "update-alternatives --install \"${link}\" \"${name}\" \"${path}\" ${priority}":
    path    => "/usr/bin:/usr/sbin:/bin",
    unless  => "grep \"${name}\" /var/lib/dpkg/alternatives/${name}",
  }
}
