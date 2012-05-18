# This class creates a vhost for reposado, it requires the puppetlabs-apache module to be installed.
# You do not have to use this class to set up a reposado vhost, it is here for convenience only.
class reposado::apache(	 
	$updates_dir   = $reposado::params::updates_dir,
	$vhost_name    = $reposado::params::vhost_name,
	$vhost_port    = $reposado::params::vhost_port,
	$vhost_aliases = $reposado::params::vhost_aliases
) inherits reposado::params {
	
	apache::vhost { $vhost_name:
		priority      => '99',
		port          => $vhost_port,
		docroot       => $updates_dir,
		vhost_name    => $vhost_name,
		serveraliases => $vhost_aliases,
		template      => 'reposado/reposado-vhost.conf.erb',
		options       => 'FollowSymLinks',
	}	
}