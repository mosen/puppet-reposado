# Reposado module for Puppet

This module allows you to install and configure [reposado](https://github.com/wdas/reposado).
It requires the [vcsrepo](https://github.com/puppetlabs/puppet-vcsrepo) type to clone reposado from the github repository.

# Usage

## Installation

The reposado::install class installs the reposado tools and creates all the required directories, it will also
automatically schedule a cron job to synchronize your update repository nightly.

    class { 'reposado::install':
    	# The directory where the reposado utility will reside
    	root_dir => "/usr/local/reposado",

    	# The directory where the updates will reside, most likely a different partition (Currently requires ~48GB)
    	updates_dir => "${root_dir}/html",

    	# The directory where the metadata will reside.
    	meta_dir => "${root_dir}/metadata",

    	# The local catalog url base, which will be the base url prefix for all updates, this should be the url that
    	# your clients will use.
    	base_url => "http://${fqdn}",

    	# Owner and group of the reposado directories and cron job.
    	reposado_user => 'root',
    	reposado_group => 'root',

    	# Group that the httpd service runs as, to ensure read access to updates and meta directories.
    	# The updates and metadata directories will still be owned by the reposado user.
    	www_group => 'apache',

    	# Advanced Options
    	# These are not normally required
    	# ----------------

    	# Options to curl
    	curl_options => [],

    	# Apple catalog urls, reposado already comes with the correct urls
    	catalog_urls => [],

    	# Preferred localizations
    	preferred_locales => [],

    	# Path to curl binary
    	curl_path => '',
    }

### Examples

Basic installation which will default to all contents being placed in /usr/local/reposado.

    class { 'reposado::install': }

Or specify your own directories where the updates will reside, in your apache vhosts directory for instance.

    class { 'reposado::install':
        updates_dir => "/var/www/reposado/html",
        meta_dir    => "/var/www/reposado/metadata",
    }

## Configuration

The site URL will default to the FQDN of the machine, which will probably be wrong if you are serving reposado
from a vhost.

You need to define the `reposado` class to do configuration of reposado defaults (like the URL of your update
repository). All of the configuration options are identical to those used with `reposado::install`, so you should supply
the exact same values here.

### Examples

The most basic reposado configuration possible

    class { 'reposado':
        updates_dir => "/var/www/reposado/html",
        meta_dir    => "/var/www/reposado/metadata",
        base_url    => "http://softwareupdate.localdomain",
    }

*NOTE* that this class is not responsible for setting up and configuring apache vhosts or whichever webserver you are
using.

## TODO

- Uses outdated apache module, create Gemfile dependency on puppet-apache
- Optional module to install margarita
- Maybe re-evaluate using a params class.