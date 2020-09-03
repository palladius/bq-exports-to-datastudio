#!/usr/bin/ruby

#import re
require 'erb'
require 'erb'
require 'ostruct'

#(collection, *args)
def println(*args)
  print args #.extract_options!
  puts ''
end
# needed to convert Hash into Binding :/ https://stackoverflow.com/questions/8954706/render-an-erb-template-with-values-from-a-hash
class ErbalT < OpenStruct
  def render(template)
    ERB.new(template).result(binding)
  end
end

#from string import Template
$debug = true
#$env = 'test'


def parse_vars_from_config(file = 'config')
    # TODO import
    config = { 
      'project_id' => 'my-project' ,
      'dataset' => 'my-dataset',
    }
    config['dataset_full_path'] = config['project_id'] + '.' + config['dataset']
    return config
end

def subtitute_file(filename, parameters=[])
    config_hash = parse_vars_from_config()
    et = ErbalT.new(config_hash)
    f = File.read("queries/#{filename}.bq")
    print "Original file: #{f}" if $debug
    #renderer = ERB.new(f)
    #output = renderer.result(config_hash)
    output = et.render(f)
    print "Rendered Template: #{output}" 
end

def process_bigquery_and_execute_from_cli()
  p "Execute subtitute_file() with config, then pipe query into 'bq' command."

end
def process_config_and_invoke_datastudio_apis_to_provision_brandnew_dashboard()
  p "TODO(ricc): Create a datastudio (also ensure idempotency so i can onlyt create a single DS per 10 executions.."
  exit 41
end

def main
    args = ARGV
    first_argument = ARGV[0] rescue nil
    print "ENV:\t#{ ENV["ENV"]}\n"
    $env =  ENV["ENV"] rescue 'test'
    print "ARGV:\t#{args}\n" 
    subtitute_file("test",         %w( project_id dataset_name )) if $env == 'test'
    subtitute_file("gcp-bq-audit", %w( project_id dataset_name )) if $env == 'prod'
    if first_argument == 'bqcli'
      process_bigquery_and_execute_from_cli()
    elsif first_argument == 'bqcli'
      process_config_and_invoke_datastudio_apis_to_provision_brandnew_dashboard()
    else 
      print "Unknown command. first_argument='#{first_argument}'"
    end
end


main()