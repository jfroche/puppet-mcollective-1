class mcollective::install::redhat {

  package { 'stomp':
    ensure => 'installed',
    name   => 'rubygem-stomp',
  }

  package { 'mcollective':
    ensure  => '2.2.0',
    alias   => 'mcollective',
    require => Package['stomp'],
  }

}

