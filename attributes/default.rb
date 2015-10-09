# General Piwik configuration parameters.
default['mo_piwik']['databag'] = node["mo_application"]["databag"]
default['mo_piwik']['id'] = "piwik"
default['mo_piwik']['user'] = "piwik"
default['mo_piwik']['group'] = "piwik"
default['mo_piwik']['path'] = "/opt/piwik"
default['mo_piwik']['action'] = :install

default['mo_piwik']['migration_command'] = <<-EOCMD
    curl -sS https://getcomposer.org/installer | #{php_command}
    #{php_command} composer.phar install
  EOCMD

default['mo_piwik']['shared_dirs'] = {}

default['mo_piwik']['shared_files'] = {
      "config/config.ini.php" => "config/config.ini.php"
}

# GIT repository information.
default['mo_piwik']['repo'] = "https://github.com/piwik/piwik.git"
default['mo_piwik']['revision'] = "2.14.3"
default['mo_piwik']['enable_submodules'] = true

default['mo_piwik']['databases'] = { 
  "piwik" => {
    'name'      => 'piwik',
    'host'      => '127.0.0.1',
    'port'      =>  3306,
    'username'  => 'piwik',
    'password'  => 'password',
    'type'      => 'mysql'
  }
}

default['mo_piwik']['application_servers'] = ['localhost']

# Virtual host options
default['mo_piwik']['applications']['frontend']['server_name'] = node.fqdn
default['mo_piwik']['applications']['frontend']['relative_document_root'] = ''

default['mo_piwik']['applications']['frontend']['php_filename'] = "(index|piwik)"

default['mo_piwik']['backup']['archives'] =  ['shared/config', 'current/plugins'].map {|x| ::File.join(node['mo_piwik']['path'],'app',x) }
default['mo_piwik']['backup']['daily_keeps'] = 3
default['mo_piwik']['backup']['weekly_keeps'] = 1
default['mo_piwik']['backup']['monthly_keeps'] = 1

default['mo_application']['packages'] = (Array(node['mo_application']['packages']) + %w(curl)).uniq

