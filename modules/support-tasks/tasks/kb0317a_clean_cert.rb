#!/opt/puppetlabs/puppet/bin/ruby

# Puppet Task to clean a node's certificate
# This can only be run against the Puppet Master.

# Parameters:
#   * agent_certnames - A comma-separated list of agent certificates to clean/remove.

# Original code by Nate McCurdy
# https://github.com/natemccurdy/puppet-purge_node

require 'puppet'
require 'open3'

Puppet.initialize_settings

# This task only works when running against your Puppet CA server, so let's check for that.
# In Puppetserver, that means that the bootstrap.cfg file contains 'certificate-authority-service'.
bootstrap_cfg = '/etc/puppetlabs/puppetserver/bootstrap.cfg'
if !File.exist?(bootstrap_cfg) || File.readlines(bootstrap_cfg).grep(%r{^[^#].+certificate-authority-service$}).empty?
  puts 'This task can only be run on your certificate authority Puppet master (MoM)'
  exit 1
end

# Version 6 and higher use the 'puppetserver' command for cleaning certs
cmd = if Puppet::Util::Package.versioncmp(Puppet.version, '6.0.0') >= 0
        ['/opt/puppetlabs/bin/puppetserver', 'ca', 'clean', '--certname']
      else
        ['/opt/puppetlabs/puppet/bin/puppet', 'cert', 'clean']
      end

def clean_cert(agent, cmd)
  stdout, stderr, status = Open3.capture3(*[cmd, agent].flatten)
  {
    stdout: stdout.strip,
    stderr: stderr.strip,
    exit_code: status.exitstatus,
  }
end

results = {}
agents = ENV['PT_agent_certnames'].split(',')

agents.each do |agent|
  results[agent] = {}

  if agent == Puppet[:certname]
    results[agent][:result] = 'Refusing to remove the Puppet Master certificate'
    next
  end

  output = clean_cert(agent, cmd)
  results[agent][:result] = output[:exit_code].zero? ? 'Certificate removed' : output
end

puts results.to_json

exit(results.values.all? { |v| v[:result] == 'Certificate removed' }) ? 0 : 1
