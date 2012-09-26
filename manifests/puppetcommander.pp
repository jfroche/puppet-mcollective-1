class mcollective::puppetcommander {
  file {
    '/etc/init.d/puppetcommander':
      ensure => present,
      source => 'puppet:///modules/mcollective/plugins/agent/puppetd/commander/puppetcommander.init',
      mode   => '0755',
  }
  file {
    '/etc/puppetcommander.cfg':
      ensure => present,
      source => 'puppet:///modules/mcollective/puppetcommander.cfg',
  }
  file {
    '/etc/sysconfig/puppetcommander':
      ensure  => present,
      content => 'MCOLLECTIVE_EXTRA_OPTS=""'
  }
  file {
    '/usr/sbin/puppetcommanderd':
      ensure => present,
      source => 'puppet:///modules/mcollective/plugins/agent/puppetd/commander/puppetcommanderd',
      mode   => '0755',
  }
  service {
    'puppetcommander':
      ensure     => running,
      hasstatus  => true,
      hasrestart => true,
      require    => File[
        '/usr/sbin/puppetcommanderd',
        '/etc/sysconfig/puppetcommander',
        '/etc/puppetcommander.cfg',
        '/etc/init.d/puppetcommander'
      ],
  }
}
