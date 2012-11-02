class ruby($version = 'ruby-1.9.3-p125') {
  include "ruby::$operatingsystemrelease"
  
  class 10.04 {
    include stow

    file { "ruby-stow-boot":
      ensure => 'present',
      path => '/root/install-ruby-stow',
      owner => 'root', group => 'root', mode => '0774',
      source => 'puppet:///modules/ruby/install-ruby-stow';
    }

    exec { "ruby-stow":
      command => "/root/install-ruby-stow",
      creates => "/usr/local/stow/${version}",
      timeout => "-1",
      require => [Package["stow"], File["ruby-stow-boot"]];
    }

  }

  class 12.04 {
    $packagelist = ['ruby1.9.1', 'ruby1.9.1-dev', 'libruby1.9.1']
    package { $packagelist: 
      ensure => installed
    }
  }
  
  # Dependencies
  $packagelist = ['sqlite3', 'libsqlite3-dev', 'libreadline-dev', 'libxml2', 'libxml2-dev', 'libxslt1-dev', 'build-essential', 'libcurl4-openssl-dev']
  package { $packagelist: 
    ensure => installed
  }
}