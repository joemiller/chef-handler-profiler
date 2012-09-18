# Chef (simple) Profiler for reporting cookbook execution times
#
# Author:: Joe Miller <https://github.com/joemiller>
# Copyright:: Copyright 2012 Joe Miller
# License:: MIT License
#


class Chef
  class Handler
    class Profiler < Chef::Handler
      VERSION = '0.0.1'

      def report
        cookbooks = Hash.new(0)
        recipes = Hash.new(0)
        resources = Hash.new(0)

        # collect all profiled timings and group by type
        all_resources.each do |r|
          cookbooks[r.cookbook_name] += r.elapsed_time
          recipes["#{r.cookbook_name}::#{r.recipe_name}"] += r.elapsed_time
          resources["#{r.resource_name}[#{r.name}]"] = r.elapsed_time
        end

        # print each timing by group, sorting with highest elapsed time first
        Chef::Log.debug "Elapsed_time  Cookbook"
        Chef::Log.debug "------------  -------------"
        cookbooks.sort_by{ |k,v| -v }.each do |cookbook, run_time|
          Chef::Log.debug "%12f  %s" % [run_time, cookbook]
        end
        Chef::Log.debug ""

        Chef::Log.debug "Elapsed_time  Recipe"
        Chef::Log.debug "------------  -------------"
        recipes.sort_by{ |k,v| -v }.each do |recipe, run_time|
          Chef::Log.debug "%12f  %s" % [run_time, recipe]
        end
        Chef::Log.debug ""

        Chef::Log.debug "Elapsed_time  Resource"
        Chef::Log.debug "------------  -------------"
        resources.sort_by{ |k,v| -v }.each do |resource, run_time|
          Chef::Log.debug "%12f  %s" % [run_time, resource]
        end
        Chef::Log.debug ""
      end

    end
  end
end
