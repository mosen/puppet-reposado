# This class configures reposado
# You should declare reposado::install first.
class reposado (
	$updates_dir = $reposado::params::updates_dir,	
	$meta_dir = $reposado::params::meta_dir,
	$base_url = $reposado::params::base_url,
	
	$reposado_user = $reposado::params::reposado_user,
	$reposado_group = $reposado::params::reposado_group,
	
	$curl_options = $reposado::params::curl_options,
	$catalog_urls = $reposado::params::catalog_urls,
	$preferred_locales = $reposado::params::preferred_locales,
	$curl_path = $reposado::params::curl_path
		
) inherits reposado::params {
		
	file { "${root_dir}/code/preferences.plist":
		ensure  => present,
		owner   => $reposado_user,
		group   => $reposado_group,
		mode    => 0664,
		content => template("reposado/preferences.plist.erb"),
	}		
}