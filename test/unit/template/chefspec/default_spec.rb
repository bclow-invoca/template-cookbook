#
# template-cookbook::default
#
require_relative 'spec_helper'

describe 'template-cookbook::default' do
  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      env = Chef::Environment.new
      env.name 'test'

      allow(node).to receive(:chef_environment).and_return(env.name)
      allow(Chef::Environment).to receive(:load).and_return(env)
    end.converge(described_recipe)
  end

  context 'check defaults' do
    it 'does not use DNS resolution' do
      expect(chef_run.node["openssh"]["server"]["use_dns"]).to include('no')
    end
    it 'permits user environment veriables to be passed' do
      expect(chef_run.node['openssh']['server']['permit_user_environment']).to include('yes')
    end
    it 'does not permit password authentication' do
      expect(chef_run.node["openssh"]["server"]["password_authentication"]).to include('no')
    end
    it 'does not permit root login' do
      expect(chef_run.node["openssh"]["server"]["permit_root_login"]).to include('no')
    end
    it 'permits x11 forwarding' do
      expect(chef_run.node["openssh"]["server"]["x11_forwarding"]).to include('yes')
    end
    it 'uses /usr/libexec/openssh/sftp-server sftp server' do
      expect(chef_run.node["openssh"]["server"]["subsystem"]).to include('sftp /usr/libexec/openssh/sftp-server')
    end
  end

  context 'checking something chef related' do
    it 'creates chef working directory' do
      expect(chef_run).to create_directory('/etc/chef')
    end
    it 'creates chef client.rb' do
      expect(chef_run).to create_file('/etc/chef/client.rb')
    end
  end

  %w(
    openssh::default
  ).each do |r|
    it "requires #{r}" do
      expect(chef_run).to include_recipe(r)
    end
  end
end
