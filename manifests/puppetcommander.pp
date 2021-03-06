class mcollective::puppetcommander {

  file {
    '/etc/init.d/puppetcommander':
      ensure => present,
      source => 'puppet:///modules/mcollective/plugins/agent/puppetd/commander/puppetcommander.init',
      mode   => '0755',
      notify => Service['puppetcommander'],
  }

  file {
    '/etc/puppetcommander.cfg':
      ensure => present,
      source => 'puppet:///modules/mcollective/puppetcommander.cfg',
      notify => Service['puppetcommander'],
  }
  case $::operatingsystem {
    redhat,centos: {
      file {
        '/etc/sysconfig/puppetcommander':
          ensure  => present,
          content => 'MCOLLECTIVE_EXTRA_OPTS=""',
          notify  => Service['puppetcommander']
      }
    }
    default: {
      file {
        '/etc/sysconfig/puppetcommander':
          ensure  => absent
      }
    }

  }

  file {
    '/usr/sbin/puppetcommanderd':
      ensure => present,
      source => 'puppet:///modules/mcollective/plugins/agent/puppetd/commander/puppetcommanderd',
      mode   => '0755',
      notify => Service['puppetcommander'],
  }
  service {
    'puppetcommander':
      ensure     => running,
      hasstatus  => true,
      require    => File[
        '/usr/sbin/puppetcommanderd',
        '/etc/sysconfig/puppetcommander',
        '/etc/puppetcommander.cfg',
        '/etc/init.d/puppetcommander'
      ],
  }
}
