# This class creates a vhost for reposado, it requires the puppetlabs-apache module to be installed.
# You do not have to use this class to set up a reposado vhost, it is here for convenience only.
class reposado::apache(	 
	$updates_dir   = $reposado::params::updates_dir,
	$vhost_name    = $reposado::params::vhost_name,
	$vhost_port    = $reposado::params::vhost_port,
	$vhost_aliases = $reposado::params::vhost_aliases
) inherits reposado::params {

  apache::vhost { $servername:
    priority      => '99',
    port          => $vhost_port,
    docroot       => $updates_dir,
    vhost_name    => $vhost_name,
    serveraliases => $vhost_aliases,
    options       => 'FollowSymLinks',
    rewrites => [
      {
        comment       => 'Redirect 10.4 Tiger',
        rewrite_cond  => ['%{HTTP_USER_AGENT} Darwin/8'],
        rewrite_rule  => ['^/index(.*)\.sucatalog$ /content/catalogs/index$1.sucatalog [L]'],
      },
      {
        comment       => 'Redirect 10.5 Leopard',
        rewrite_cond  => ['%{HTTP_USER_AGENT} Darwin/9'],
        rewrite_rule  => ['^/index(.*)\.sucatalog$ /content/catalogs/others/index-leopard.merged-1$1.sucatalog [L]'],
      },
      {
        comment       => 'Redirect 10.6 Snow Leopard',
        rewrite_cond  => ['%{HTTP_USER_AGENT} Darwin/10'],
        rewrite_rule  => ['^/index(.*)\.sucatalog$ /content/catalogs/others/index-leopard-snowleopard.merged-1$1.sucatalog [L]'],
      },
      {
        comment       => 'Redirect 10.7 Lion',
        rewrite_cond  => ['%{HTTP_USER_AGENT} Darwin/11'],
        rewrite_rule  => ['^/index(.*)\.sucatalog$ /content/catalogs/others/index-lion-snowleopard-leopard.merged-1$1.sucatalog [L]'],
      },
      {
        comment       => 'Redirect 10.8 Mountain Lion',
        rewrite_cond  => ['%{HTTP_USER_AGENT} Darwin/12'],
        rewrite_rule  => ['^/index(.*)\.sucatalog$ /content/catalogs/others/index-mountainlion-lion-snowleopard-leopard.merged-1$1.sucatalog [L]'],
      },
      {
        comment       => 'Redirect 10.9 Mavericks',
        rewrite_cond  => ['%{HTTP_USER_AGENT} Darwin/13'],
        rewrite_rule  => ['^/index(.*)\.sucatalog$ /content/catalogs/others/index-10.9-mountainlion-lion-snowleopard-leopard.merged-1$1.sucatalog [L]'],
      }
    ]
  }

}