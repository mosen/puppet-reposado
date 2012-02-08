# This class installs reposado
# It does not create a vhost or serve the updates via http, for that you must configure your own
# apache vhost.
class reposado::install(	 
	$root_dir = $reposado::params::root_dir,	
	$updates_dir = $reposado::params::updates_dir,	
	$meta_dir = $reposado::params::meta_dir,
	$reposado_user = $reposado::params::reposado_user,
	$reposado_group = $reposado::params::reposado_group,
	$www_group = $reposado::params::www_group
) inherits reposado::params {

	# TODO: Check for python matching v2.6

	package { "curl": # Required for repo_sync
		ensure => installed,
	}

	vcsrepo { $root_dir:
		ensure   => latest,
		provider => git,
		source   => "https://github.com/wdas/reposado.git",
	}

	file { "${root_dir}/code/repoutil":
		owner   => $reposado_user,
		group   => $reposado_group,
		mode    => 0755,
		require => Vcsrepo[$root_dir],
	}
	
	file { "${root_dir}/code/repo_sync":
		owner   => $reposado_user,
		group   => $reposado_group,
		mode    => 0755,
		require => Vcsrepo[$root_dir],
	}
	
	# Prepare the sync directories prior to syncing.
	
	file { $updates_dir:
		ensure  => directory,
		owner   => $reposado_user,
		group   => $www_group,
		mode    => 0755,
		# require => File[$root_dir],
	}

	file { $meta_dir:
		ensure  => directory,
		owner   => $reposado_user,
		group   => $www_group,
		mode    => 0755,
		# require => File[$root_dir],
	}
	
	cron { "repo_sync":
		ensure  => present,
		command => "${root_dir}/code/repo_sync",
		user    => $reposado_user,
		hour    => 2,
		minute  => 0,
		require => File["${root_dir}/code/preferences.plist", $updates_dir, $meta_dir],
	}
}