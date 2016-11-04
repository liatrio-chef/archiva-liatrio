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
end
