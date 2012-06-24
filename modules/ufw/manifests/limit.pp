define ufw::limit::host {
  exec {"ufw limit from ${name}":
    unless => "ufw status | grep -E \"Anywhere +LIMIT +${name}\"",
    require => Exec["ufw default deny"],
    before => Exec["ufw enable"],    
    }
}

define ufw::limit::service {
  exec {"ufw limit ${name}":
    unless => "ufw status | grep -E \"${name} +LIMIT +Anywhere\"",
    require => Exec["ufw default deny"],
    before => Exec["ufw enable"],    
    }
}
