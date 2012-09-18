$:.push File.expand_path('../lib/chef/handler', __FILE__)

require 'chef_profiler'


desc "build a new .gem"
task :build do
  system 'gem build chef-handler-profiler.gemspec'
end

desc "push .gem to rubygems.org"
task :release do
  system "gem push chef-handler-profiler-#{Chef::Handler::Profiler::VERSION}.gem"
end

task :default => :build
