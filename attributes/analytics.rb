default['mo_piwik']['analytics']['repo'] = 'https://github.com/piwik/piwik-log-analytics.git'
default['mo_piwik']['analytics']['revision'] = 'master'
default['mo_piwik']['analytics']['base_dir'] = "/opt/piwik-analytics"
default['mo_piwik']['analytics']['syslog_script'] = "/usr/local/bin/piwik-analytics.sh"
default['mo_piwik']['analytics']['piwik_url'] = "http://piwik.example.net"
default['mo_piwik']['analytics']['token_auth'] = "123456"
default['mo_piwik']['analytics']['recorders'] = node.cpu.total
