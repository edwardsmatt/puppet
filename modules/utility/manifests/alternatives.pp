define utility::alternatives::install($link, $name, $path, $priority="1") {
  exec {"update-alternatives --install \"${link}\" \"${name}\" \"${path}\" ${priority}":
    path   => "/usr/bin:/usr/sbin:/bin",
    unless => "grep \"${name}\" /var/lib/dpkg/alternatives/${name}",
  }
}

define utility::alternatives::set($name, $path) {
  exec {"update-alternatives --set \"${name}\" \"${path}\"":
    path   => "/usr/bin:/usr/sbin:/bin",
    unless => "update-alternatives --get-selections|grep  \"${name} .*[auto|manual] .*${path}\"",
  }
}
