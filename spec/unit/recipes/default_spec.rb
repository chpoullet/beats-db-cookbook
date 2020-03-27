#
# Cookbook:: beatsdb_cookbook
# Spec:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'beatsdb_cookbook::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '18.04'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'should update source list' do
      expect(chef_run).to update_apt_update('update_sources')
    end
    
    it 'should create a metricbeat template in etc/metricbeat/metricbeat.yml' do
      expect(chef_run).to create_template('etc/metricbeat/metricbeat.yml')
    end
    
    it 'should create a filebeat template in etc/filebeat/filebeat.yml' do
      expect(chef_run).to create_template('etc/filebeat/filebeat.yml')
    end
  end
end
