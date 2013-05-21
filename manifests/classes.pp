
class webserver::custom_php {
  class {'php::params':
    package        => "php",
    package_common => "php-common",
    memory_limit   => "129M"
  }
  
  include php
  
  include php::apc
  php::extension { 'mcrypt': }
  php::extension { 'mysql': }
  php::extension { 'gd': }
  php::extension { 'xml': }
  php::extension { 'mbstring': }
  php::extension { 'pecl-memcache': }
}

class webserver::custom_apache {
  class {'apache::params':
    port => 8080,
  }
  include apache
}

class webserver::custom_tomcat {
  class {'tomcat::params':
    port => 8081,
  }
  include tomcat
}

class webserver::drupal {
  apache::vhost { "127.0.0.1":
    documentroot => "/var/www/drupal",
    port         => 8080
  }
}

class webserver {
  include webserver::custom_apache
  include memcached
  include webserver::custom_php
  include varnish
#  include drupal

  include mysql::server
  include mysql::client

  include webserver::drupal

#  include webserver::custom_tomcat 
#  include solr  

  include drush
}
