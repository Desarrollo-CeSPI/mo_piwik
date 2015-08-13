#############################################################################
#The following settings must be setted before rsyslog recipe is included
#############################################################################
node.set['rsyslog']['modules'] = (Array(node['rsyslog']['modules']) + ['omprog']).uniq
node.set['rsyslog']['default_facility_logs'][%Q($template)]= %q(PIWIK_Template, "%msg%\n")
node.set['rsyslog']['default_facility_logs'][%Q(:programname, startswith, "piwik-")]= %Q({action(type="omprog" binary="#{node['mo_piwik']['analytics']['syslog_script']}" template="PIWIK_Template")})

package 'git'

git node['mo_piwik']['analytics']['base_dir'] do
  repository node['mo_piwik']['analytics']['repo']
  revision node['mo_piwik']['analytics']['revision']
end

file node['mo_piwik']['analytics']['syslog_script'] do
  content <<-SCRIPT
#!/bin/bash
#{node['mo_piwik']['analytics']['base_dir']}/import_logs.py \
  --url=#{node['mo_piwik']['analytics']['piwik_url']} \
  --token-auth=#{node['mo_piwik']['analytics']['token_auth']} \
  --recorders=#{node['mo_piwik']['analytics']['recorders']} \
  --enable-http-errors \
  --enable-http-redirects \
  --enable-static \
  --enable-bots \
  --log-format-name=nginx_json \
  --add-sites-new-hosts -
  SCRIPT
  mode "0755"
end
