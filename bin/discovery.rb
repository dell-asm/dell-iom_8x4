#!/opt/puppet/bin/ruby

require 'trollop'
require 'pathname'
require 'timeout'
require 'puppet'

modules_path = File.expand_path(Pathname.new(__FILE__).parent.parent.parent)
#$LOAD_PATH << File.join(modules_path, 'dell_iom/lib')
$LOAD_PATH << File.join(modules_path, 'iom_8x4/lib')
require 'puppet_x/iom_8x4/transport'

facts = {}
opts = Trollop::options do
  opt :server, 'switch address', :type => :string, :required => true
  opt :port, 'switch port', :default => 22
  opt :username, 'switch username', :type => :string
  opt :password, 'switch password', :type => :string, :default => ENV['PASSWORD']
  opt :timeout, 'command timeout', :default => 240
  opt :community_string, 'dummy value for ASM, not used'
end

begin
  if opts[:username].nil? || opts[:password].nil?
    puts "Must give username and password parameters."
    exit 1
  end
  Timeout.timeout(opts[:timeout]) do
    device_conf = {:scheme => 'ssh', :host => opts[:server], :port => opts[:port], :password => opts[:password], :user=>opts[:username] }
    transport = PuppetX::Iom8x4::Transport.new(nil, {:device_config => device_conf})
    facts = transport.facts
  end
rescue Timeout::Error
  puts "Timed out getting facts."
  exit 1
rescue Exception => e
  puts "#{e}\n#{e.backtrace.join("\n")}"
  exit 1
else
  if facts.empty?
    puts "Could not get updated facts"
    exit 1
  else
    facts.each do |fact, value|
      facts[fact] = value.to_s
    end
    puts facts.to_json
    exit 0
  end
end