# default path
Exec {
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}

include bootstrap
include tools

include apache
apache::mod { 'rewrite': }

#include php::cli 
#include php::mod_php5

#php::module { 'xdebug':}


include mysql::server
include gcc

package { 'gdb':
	ensure => 'present',
	}

include git
git::config { 'user.name':
  value => 'antoniocs',
}

git::config { 'user.email':
  value => 'antoniocs@gmail.com',
}

package { 'puppet': 
	ensure => 'latest',
}

