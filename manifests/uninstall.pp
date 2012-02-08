# This class uninstalls reposado
# It does not remove a vhost.
class reposado::uninstall(	 
	$remove_users = false
) inherits reposado::params {

	file { $root_dir:
		ensure => absent,
	}
	
	# TODO: remove users option

	cron { "repo_sync":
		ensure  => absent,
	}
}