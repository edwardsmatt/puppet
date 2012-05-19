class admin::augeas {
  package { ["augeas-lenses", "augeas-tools"]:
    ensure => "present",
  }
}
