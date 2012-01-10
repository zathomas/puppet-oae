# = Class: oae::solr
#
# This class installs a standalone solr master or slave for Sakai OAE
#
# == Parameters:
#
# $solr_tarball:: A URL to a tarball of the solr build.
#
# $solrconfig::   A template to render the solrconfig.xml file.
#
# $schema::       A template to render the schema.xml file.
#
# $solr_git::     The url for the solr git repository
#
# $solr_tag::     The tag to checkout (optional)
#
# $master_url::   The master url for solr clustering (necessary for slave configurations)
#
# == Actions:
#   Install a solr server.
#
# == Sample Usage:
# 
#   class { 'oae::solr::jetty':
#     solr_tarball => "http://source.sakaiproject.org/release/oae/solr/solr-example.tar.gz",
#     solrconfig   => 'myconfig/solrconfig.xml.erb',
#     schema       => 'myconfig/schema.xml.erb',
#   }
#

class oae::solr::jetty() {

    file { '/etc/init.d/solr':
        ensure => present,
        owner  => $oae::params::user,
        group  => $oae::params::user,
        mode   => 0755,
        content => template("oae/solr.erb"),
    }

    service { 'solr':
        ensure => running,
        subscribe => [ 
            File["${solr_conf_dir}/solrconfig.xml"], 
            File["${solr_conf_dir}/schema.xml"], 
        ],
        
    }
}
