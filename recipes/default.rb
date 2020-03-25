#
# Cookbook:: beatsdb_cookbook
# Recipe:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

include_recipe 'apt'
apt_update 'update_sources' do
  action :update
end

apt_update "update" do
  action :update
end

execute 'download_metricbeat' do
  command 'curl -L -O https://artifacts.elastic.co/downloads/beats/metricbeat/metricbeat-7.6.1-amd64.deb'
end

execute 'install_metricbeat' do
  command 'sudo dpkg -i metricbeat-7.6.1-amd64.deb'
end


execute 'download_filebeat' do
  command 'curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.6.1-amd64.deb'
end

execute 'install_filebeat' do
  command 'sudo dpkg -i filebeat-7.6.1-amd64.deb'
end


template 'etc/metricbeat/metricbeat.yml' do
  source 'metricbeat.yml.erb'
  mode '777'
  owner 'root'
  group 'root'
end

execute 'fix_template' do
  command 'sudo chmod go-w /etc/metricbeat/metricbeat.yml'
end

template 'etc/filebeat/filebeat.yml' do
  source 'filebeat.yml.erb'
  mode '777'
  owner 'root'
  group 'root'
end

execute 'fix_template' do
  command 'sudo chmod go-w /etc/filebeat/filebeat.yml'
end

execute 'enable_module_mongodb' do
  command 'sudo metricbeat modules enable mongodb'
end

execute 'enable_module_system' do
  command 'sudo metricbeat modules enable system'
end

#execute 'setup_dasboards' do
#  command 'sudo metricbeat setup'
#end

execute 'enable_module_syslogs' do
  command 'sudo filebeat modules enable system'
end



#execute 'setup_dasboards' do
#  command 'sudo filebeat setup'
#end

service 'metricbeat' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end

service 'filebeat' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end
