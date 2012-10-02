class mcollective::install::redhat {

  package { 'stomp':
    ensure => 'installed',
    name   => 'rubygem-stomp',
  }

  package { 'mcollective':
    ensure    => $::operatingsystemrelease ? {
      /^6/    => '2.2.0-1.el6',
      default => '2.2.0-1.el5',
    },
    alias     => 'mcollective',
    require   => Package['stomp'],
  }

}

