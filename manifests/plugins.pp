class mcollective::plugins {

  case $::operatingsystem {
    debian,ubuntu: { $p_base = '/usr/share/mcollective/plugins/mcollective' }
    redhat,centos: { $p_base = '/usr/libexec/mcollective/mcollective' }
    default: { fail("${::hostname}: mcollective: trying to install unsupported operatingsystem ${::operatingsystem}") }
  }

  $s_base = 'puppet:///modules/mcollective/plugins'

  File {
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['mcollective'],
    notify  => Service['mcollective'],
  }

  file { "${p_base}/facts/facter.rb":
    source => "${s_base}/facts/facter/facter.rb",
  }
  file { "${p_base}/agent/service.rb":
    source => "${s_base}/agent/service/agent/puppet-service.rb",
  }
  file { "${p_base}/agent/service.ddl":
    source => "${s_base}/agent/service/agent/service.ddl",
  }
  file { "${p_base}/agent/package.rb":
    source => "${s_base}/agent/package/agent/puppet-package.rb",
  }
  file { "${p_base}/agent/package.ddl":
    source => "${s_base}/agent/package/agent/package.ddl",
  }
  file { "${p_base}/agent/nrpe.rb":
    source => "${s_base}/agent/nrpe/agent/nrpe.rb",
  }
  file { "${p_base}/agent/nrpe.ddl":
    source => "${s_base}/agent/nrpe/agent/nrpe.ddl",
  }
  file { "${p_base}/agent/puppetd.rb":
    source => "${s_base}/agent/puppetd/agent/puppetd.rb",
  }
  file { "${p_base}/agent/puppetd.ddl":
    source => "${s_base}/agent/puppetd/agent/puppetd.ddl",
  }
  file { "${p_base}/agent/filemgr.rb":
    source => "${s_base}/agent/filemgr/agent/filemgr.rb",
  }
  file { "${p_base}/agent/filemgr.ddl":
    source => "${s_base}/agent/filemgr/agent/filemgr.ddl",
  }
  file { "${p_base}/facts/facter_facts.rb":
    source => "${s_base}/facts/facter/facter_facts.rb",
  }
}
