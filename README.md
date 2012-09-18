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

    include_recipe "chef_handler"

    # Install `chef-handler-profiler` gem during the compile phase
    chef_gem "chef-handler-profiler"

    # load the gem here so it gets added to the $LOAD_PATH, otherwise chef_handler
    # will fail.
    require 'chef/handler/chef_profiler'

    # Activate the handler immediately during compile phase
    chef_handler "Chef::Handler::Profiler" do
      source "chef/handler/chef_profiler"
      action :nothing
    end.run_action(:enable)


### Method 2

Install the gem ahead of time, and configure Chef to use
them:

    gem install chef-handler-profiler

Then add to the configuration (`/etc/chef/solo.rb` for chef-solo or
`/etc/chef/client.rb` for chef-client):

    require "chef/handler/chef_profiler"
    report_handlers << Chef::Handler::Profiler.new
    exception_handlers << Chef::Handler::Profiler.new


### Example output

Run chef with `-l debug` to see profiler output, example:

    $ chef-solo -j config.json -l debug
    ...
    [2012-09-18T17:40:31+00:00] INFO: Running report handlers
    [2012-09-18T17:40:31+00:00] INFO: Resources updated this run:
    [2012-09-18T17:40:31+00:00] INFO:   chef_handler[Chef::Handler::Profiler]
    [2012-09-18T17:40:31+00:00] DEBUG: Elapsed_time  Cookbook
    [2012-09-18T17:40:31+00:00] DEBUG: ------------  -------------
    [2012-09-18T17:40:31+00:00] DEBUG:    16.040867  python
    [2012-09-18T17:40:31+00:00] DEBUG:     7.831706  nano
    [2012-09-18T17:40:31+00:00] DEBUG:     3.233159  base
    [2012-09-18T17:40:31+00:00] DEBUG:     0.699011  generic-users
    [2012-09-18T17:40:31+00:00] DEBUG:     0.665569  chef
    [2012-09-18T17:40:31+00:00] DEBUG:     0.176383  postfix
    [2012-09-18T17:40:31+00:00] DEBUG:     0.174411  ntp
    [2012-09-18T17:40:31+00:00] DEBUG:     0.001780  chef_handler
    [2012-09-18T17:40:31+00:00] DEBUG: 
    [2012-09-18T17:40:31+00:00] DEBUG: Elapsed_time  Recipe
    [2012-09-18T17:40:31+00:00] DEBUG: ------------  -------------
    [2012-09-18T17:40:31+00:00] DEBUG:    16.040867  python::default
    [2012-09-18T17:40:31+00:00] DEBUG:     7.831706  nano::default
    [2012-09-18T17:40:31+00:00] DEBUG:     1.414983  base::pki
    [2012-09-18T17:40:31+00:00] DEBUG:     1.228345  base::utilities
    [2012-09-18T17:40:31+00:00] DEBUG:     0.699011  generic-users::default
    [2012-09-18T17:40:31+00:00] DEBUG:     0.660846  chef::omnibus
    [2012-09-18T17:40:31+00:00] DEBUG:     0.374277  base::default
    [2012-09-18T17:40:31+00:00] DEBUG:     0.176383  postfix::default
    [2012-09-18T17:40:31+00:00] DEBUG:     0.174411  ntp::default
    [2012-09-18T17:40:31+00:00] DEBUG:     0.103661  base::dracut
    [2012-09-18T17:40:31+00:00] DEBUG:     0.085744  base::users
    [2012-09-18T17:40:31+00:00] DEBUG:     0.010829  base::sshd_allow
    [2012-09-18T17:40:31+00:00] DEBUG:     0.005859  base::kernel
    [2012-09-18T17:40:31+00:00] DEBUG:     0.005025  base::sudoers
    [2012-09-18T17:40:31+00:00] DEBUG:     0.004723  chef::profiler_handler
    [2012-09-18T17:40:31+00:00] DEBUG:     0.004437  base::prelink
    [2012-09-18T17:40:31+00:00] DEBUG:     0.001780  chef_handler::default
    [2012-09-18T17:40:31+00:00] DEBUG: 
    [2012-09-18T17:40:31+00:00] DEBUG: Elapsed_time  Resource
    [2012-09-18T17:40:31+00:00] DEBUG: ------------  -------------
    [2012-09-18T17:40:31+00:00] DEBUG:     7.755572  package[nano]
    [2012-09-18T17:40:31+00:00] DEBUG:     0.549213  remote_file[/usr/local/bin/prlimit]
    [2012-09-18T17:40:31+00:00] DEBUG:     0.483825  chef_gem[gelf]
    [2012-09-18T17:40:31+00:00] DEBUG:     0.433518  execute[remove_pip_pynotify]
    [2012-09-18T17:40:31+00:00] DEBUG:     0.391915  execute[install_clint==0.3.1]
    [2012-09-18T17:40:31+00:00] DEBUG:     0.391519  execute[install_Genshi==0.6]
    [2012-09-18T17:40:31+00:00] DEBUG:     0.389266  execute[install_Jinja2==2.6]
    [2012-09-18T17:40:31+00:00] DEBUG:     0.385632  execute[install_zope.interface==3.8.0]
    [2012-09-18T17:40:31+00:00] DEBUG:     0.384590  execute[install_gitdb==0.5.4]
    [2012-09-18T17:40:31+00:00] DEBUG:     0.384320  execute[install_pycurl==7.19.0]
    [2012-09-18T17:40:31+00:00] DEBUG:     0.382389  gem_package[teamocil]
    [2012-09-18T17:40:31+00:00] DEBUG:     0.382325  execute[install_python-dateutil==1.5]
    [2012-09-18T17:40:31+00:00] DEBUG:     0.381351  execute[install_PyMySQL==0.5]
    [2012-09-18T17:40:31+00:00] DEBUG:     0.380537  execute[install_iso8601==0.1.4]
    [2012-09-18T17:40:31+00:00] DEBUG:     0.380504  execute[install_pycassa==1.4.0]
    [2012-09-18T17:40:31+00:00] DEBUG:     0.379317  execute[install_argparse==1.2.1]
    [2012-09-18T17:40:31+00:00] DEBUG:     0.379029  execute[install_amqplib==1.0.2]
    [2012-09-18T17:40:31+00:00] DEBUG:     0.378980  execute[install_pbs==0.108]
    [2012-09-18T17:40:31+00:00] DEBUG:     0.378710  execute[install_apache-libcloud==
    ...

Todo
====

- Might be nice to dump output to JSON files.
- Different output, such as having resources grouped under their recipes,
  and recipes grouped under cookbooks.

License and Author
==================

Licensed under the MIT license. See `LICENSE` file for details.

Author:: Joe Miller <https://github.com/joemiller>, <https://twitter.com/miller_joe>
