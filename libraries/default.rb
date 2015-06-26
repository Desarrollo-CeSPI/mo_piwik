def deploy_piwik(data)
  mo_application_deploy data, :mo_application_php do
    base_dir = application_current_path
    log_dir = ::File.join(application_shared_path, 'log')
    directory log_dir do
      owner data['user']
      group data['user']
    end
    server_name = application_url data['applications']['frontend']
    cron "#{data['id']}-archiving" do
      minute (0..59).to_a.sample
      user data['user']
      command "cd #{base_dir} && #{php_command} console core:archive --url=#{server_name} >> #{log_dir}/archive.log"
    end
  end
end
