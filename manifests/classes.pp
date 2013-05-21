
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

class webserver::custom_varnish {
  class {'varnish::params':
    backend_host => "127.0.0.1",
    backend_port => 8080,    
  }
  include varnish
}

class webserver::drupal {
  apache::vhost { "localhost":
    documentroot => "/var/www/drupal",
    port         => 8080,
    aliases      => ["127.0.0.1", $ipaddress]
  }
}

class webserver {
  include webserver::custom_apache
  include memcached
  include webserver::custom_php
  include webserver::custom_varnish
  include webserver::drupal
    
  include mysql::server
  include mysql::client

#  include webserver::custom_tomcat 
#  include solr  
#  include drupal

  include drush
}
