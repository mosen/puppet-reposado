class reposado::params {
	# The directory where the reposado utility will reside
	$root_dir = "/usr/local/reposado"
	
	# The directory where the updates will reside, most likely a different partition (>100GB)
	$updates_dir = "${root_dir}/html"
	
	# The directory where the metadata will reside.
	$meta_dir = "${root_dir}/metadata"
	
	# The local catalog url base, which will be the base url prefix for all updates.
	$base_url = "http://${fqdn}"
	
	# Owner and group of the reposado directories and cron job.
	$reposado_user = "root"
	$reposado_group = "root"
	
	# Group that the httpd service runs as, to ensure read access to updates and meta directories.
	# The updates and metadata directories will still be owned by the reposado user.
	$www_group = $operatingsystem ? {
		'debian' => 'www-data',
		'CentOS' => 'apache',
	}

    # The hostname of the apache vhost (when using reposado::apache)
    $vhost_name = "${fqdn}"
    $vhost_port = "80"
    $vhost_aliases = [""]
	
	# Advanced Options
	# ----------------
	
	# Options to curl
	$curl_options = []
	
	# Apple catalog urls
	$catalog_urls = []
	
	# Preferred localizations
	$preferred_locales = []
	
	# Path to curl binary
	$curl_path = ''
}