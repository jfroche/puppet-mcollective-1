# = Class: mcollective::client::plugins
#
# Description of mcollective::client::plugins
#
class mcollective::client::plugins {

  $bin_dir = '/usr/local/bin'

  case $::operatingsystem {
    debian,ubuntu: { $p_base = '/usr/share/mcollective/plugins/mcollective' }
    redhat,centos: { $p_base = '/usr/libexec/mcollective/mcollective' }
    default: { fail("${::hostname}: mcollective: trying to install unsupported operatingsystem ${::operatingsystem}") }
  }

  $app_dir = "$p_base/application"
  $s_base = 'puppet:///modules/mcollective/plugins'

  File {
    owner   => 'root',
    group   => 'root',
    mode    => '0555',
    require => Class['mcollective::client::install'],
  }

  file { "${app_dir}/service.rb":
    source => "${s_base}/agent/service/application/service.rb",
  }
  file { "${app_dir}/package.rb":
    source => "${s_base}/agent/package/application/package.rb",
  }
  file { "${app_dir}/nrpe.rb":
    source => "${s_base}/agent/nrpe/application/nrpe.rb",
  }
  file { "${bin_dir}/mc-nrpe":
    source => "${s_base}/agent/nrpe/sbin/check-mc-nrpe",
  }
  file { "${app_dir}/puppetd.rb":
    source => "${s_base}/agent/puppetd/application/puppetd.rb",
  }
  file { "${app_dir}/filemgr.rb":
    source => "${s_base}/agent/filemgr/application/filemgr.rb",
  }

}

