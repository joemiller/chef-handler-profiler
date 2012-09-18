Description
===========

This is a Chef report handler that reports the execution time spent in each:
cookbook, recipe, and resource.

* http://wiki.opscode.com/display/chef/Exception+and+Report+Handlers

Requirements
============

Only works on Chef >= 10.14

Usage
=====

There are two ways to use Chef Handlers.

### Method 1 (recommended)

Use the
[chef_handler cookbook by Opscode](http://community.opscode.com/cookbooks/chef_handler).
Create a recipe with the following:

    # Install `chef-handler-profiler` gem during the compile phase
    chef_gem "chef-handler-profiler"

    # Activate the handler immediately during compile phase
    chef_handler "Chef::Handler::Profiler" do
      source "chef/handler/profiler"
      action :nothing
    end.run_action(:enable)


### Method 2

Install the gem ahead of time, and configure Chef to use
them:

    gem install chef-handler-profiler

Then add to the configuration (`/etc/chef/solo.rb` for chef-solo or
`/etc/chef/client.rb` for chef-client):

    require "chef/handler/profiler"
    report_handlers << Chef::Handler::Profiler.new
    exception_handlers << Chef::Handler::Profiler.new


Todo
====

- Might be nice to dump output to JSON
- Different output, such as having resources grouped under their recipes,
  and recipes grouped under cookbooks.

License and Author
==================

Licensed under the MIT license. See `LICENSE` file for details.

Author:: Joe Miller <https://github.com/joemiller>, <https://twitter.com/miller_joe>
