# default path
Exec {
  path => ["/usr/bin", "/bin", "/usr/sbin", "/sbin", "/usr/local/bin", "/usr/local/sbin"]
}

include bootstrap
include tools


#https://forge.puppetlabs.com/puppetlabs/apache
#https://groups.google.com/forum/#!msg/puppet-users/Tem7vo-iX_A/ILgFsAP2Cb8J
class { 'apache':
	mpm_module => 'prefork',
}



class {'::apache::mod::php': }
class {'::apache::mod::rewrite': }

apache::vhost { 'irunerrands.dev':
	port => '80',
	docroot => '/home/vagrant/projects/Personal/php/irunerrands/public',
	serveradmin => 'admin@admin.dev',
	options => ['Indexes','FollowSymLinks','MultiViews'],
	setenv => ["APP_ENV dev"],
	override => ['All'],
}



class { '::mysql::server':
	override_options => {
		'mysqld' => {
			'long_query_time' => 1,
			'slow_query_log' => 1,
			'slow_query_log_file' => '/var/log/mysql/mysql_slow_query',
			'log' => '/var/log/mysql/mysql_all_queries'
		}
	}
}

#http://puppet-php.readthedocs.org/en/latest/index.html

# Install extensions

include php

# Install extensions
Php::Extension <| |>
	# Configure extensions
	-> Php::Config <| |>
	# Reload webserver
	~> Service["apache2"]

class {
	[
		'php::apache',
		'php::cli',

		'php::extension::curl',
		'php::extension::imagick',
		'php::extension::mcrypt',
		'php::extension::memcached',
		'php::extension::mysql',
		'php::extension::xdebug',
		'php::composer',
		'php::composer::auto_update'
	]: 
}


php::config { 'display_errors=On':
	file => '/etc/php5/apache2/php.ini',
	#section => 'PHP', #defaults to PHP
}
php::config {
	[
		'xdebug.remote_enable=1',
		'xdebug.remote_host=192.168.56.1',
		'xdebug.remote_port=9000',
		'xdebug.remote_handler=dbgp'
	]:
	file => '/etc/php5/apache2/php.ini',
	section => 'Xdebug',
}

include phpunit


include gcc

package { 'gdb':
	ensure => 'present',
}


#Installs really old version
package { 'cmake':
	ensure => 'absent',
}
	
include git

git::config { 'user.name':
  value => 'antoniocs'
}

git::config { 'user.email':
  value => 'antoniocs@gmail.com'
}

package { 'puppet':
	ensure => 'latest',
}

package { 'inoticoming':
	ensure => 'present',
}

#package { 'clip':
#	ensure => 'present',
#}



include '::rabbitmq'
