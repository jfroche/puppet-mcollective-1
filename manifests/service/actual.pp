class mcollective::service::actual {

  include mcollective::install
  include mcollective::config
  include mcollective::plugins

  file {
    '/etc/init.d/mcollective':
      ensure => present,
      owner  => 'root',
      group  => 'root',
      mode   => '0755',
      source => 'puppet:///modules/mcollective/mcollective.init',
      notify => Service['mcollective'],
  }

  service { 'mcollective':
    ensure     => 'running',
    hasstatus  => true,
    hasrestart => true,
    require    => Class['mcollective::install'],
  }
}

