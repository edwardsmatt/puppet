define ufw::allow::host {
  exec {"ufw allow from ${name}":
    unless => "ufw status | grep -E \"Anywhere +ALLOW +${name}\"",
    require => Exec["ufw default deny"],
    before => Exec["ufw enable"],    
    }
}

define ufw::allow::service {
  exec {"ufw allow ${name}":
    unless => "ufw status | grep -E \"${name} +ALLOW +Anywhere\"",
    require => Exec["ufw default deny"],
    before => Exec["ufw enable"],    
    }
}
