# default path
Exec {
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}

include bootstrap
include tools


#https://forge.puppetlabs.com/puppetlabs/apache
include apache
apache::mod::rewrite


#include '::mysql::server'


#class { '::mysql::server':	  
#	  'override_options' => { 
#		'mysqld' => { 
#			'max_connections' => '1024',
#			'bind-address' => '0.0.0.0',
#			'log-slow-queries' => '1',
#			'slow-query-log-file' = '/var/log/mysql/slow_query.log',
#		} 
#	}
#}

#http://puppet-php.readthedocs.org/en/latest/index.html

# Install extensions

include php

class { ['php::apache','php::cli','php::extension::curl','php::extension::imagick','php::extension::mcrypt','php::extension::memcached','php::extension::mysql','php::extension::xdebug','php::composer','php::composer::auto_update']: }
class { 'php::phpunit':
  ensure => latest,
}



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

