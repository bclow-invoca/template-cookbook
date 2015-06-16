require_relative 'spec_helper'

describe 'template-cookbook::default' do
  describe package('openssh-server') do
    it { should be_installed }
  end

  describe package('openssh-client') do
    it { should be_installed }
  end

  describe service('ssh') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(22) do
    it { should be_listening.with('tcp') }
  end

  describe file('/etc/ssh/sshd_config') do
    it { should contain 'UsePAM yes' }
    it { should contain 'UseDns no' }
    it { should contain 'PermitUserEnvironment yes' }
    it { should contain 'PasswordAuthentication no' }
    it { should contain 'PermitRootLogin no' }
    it { should contain 'ChallengeResponseAuthentication no' }
    it { should contain 'X11Forwarding yes' }
    it { should contain 'Subsystem sftp /usr/libexec/openssh/sftp-server' }
  end
end
