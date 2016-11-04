#
# Cookbook Name:: archiva-liatrio
# Spec::default
#
require 'spec_helper'

describe 'archiva-liatrio::default' do
  # Set up test env.
  let(:chef_run) do
    ChefSpec::SoloRunner.new.converge(described_recipe)
  end

  it 'overrides java to Java 8' do
    expect(chef_run.node['java']['jdk_version']).to eq('8')
  end

  let(:node) { chef_run.node }

  it 'includes archiva recipe' do
    expect(chef_run).to include_recipe('archiva')
  end

  it 'creates the security.properties file' do
    expect(chef_run).to create_cookbook_file(
      '/opt/archiva/conf/security.properties'
    ).with(
      owner: 'root',
      group: 'root',
      mode: '0666'
    )
  end

  it 'runs the wait_for_archiva block' do
    expect(chef_run).to run_ruby_block('wait_for_archiva')
  end

  it 'creates the data.tar.gz file' do
    expect(chef_run).to create_cookbook_file('/opt/archiva/data.tar.gz').with(
      owner: 'root',
      group: 'root',
      mode: '0666'
    )
  end

  it 'stopes the archiva service' do
    expect(chef_run).to stop_service('archiva_stop')
  end

  it 'creates the jetty.xml template' do
    expect(chef_run).to create_template(
      "#{node[:archiva][:home]}/conf/jetty.xml"
    ).with(
      source: 'jetty.xml.erb',
      mode: '0644',
      owner: node[:archiva][:user_owner]
    )
  end

  it 'remove databases' do
    expect(chef_run).to run_execute('remove_databases').with(
      command: 'rm -rf /opt/archiva/data/'
    )
  end

  it 'untars the data' do
    expect(chef_run).to run_execute('untar_data').with(
      command: 'tar -C /opt/archiva -zxvf /opt/archiva/data.tar.gz'
    )
  end

  it 'creates the data.updated cookbook file' do
    expect(chef_run).to create_cookbook_file('/opt/archiva/data.updated').with(
      source: 'data.updated',
      owner: 'root',
      group: 'root',
      mode: '0666'
    )
  end

  it 'restarts the archiva service' do
    expect(chef_run).to enable_service('archiva_enable').with(
      service_name: 'archiva'
    )
  end
end
