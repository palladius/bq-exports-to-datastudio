#!/usr/bin/ruby

#import re
require 'erb'
require 'erb'
require 'ostruct'

# needed to convert Hash into Binding :/ https://stackoverflow.com/questions/8954706/render-an-erb-template-with-values-from-a-hash
class ErbalT < OpenStruct
  def render(template)
    ERB.new(template).result(binding)
  end
end

#from string import Template
$debug = true
$env = 'test'


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


def main
    subtitute_file("test", 
        %w( project_id dataset_name )) if $env == 'test'
    subtitute_file("gcp-bq-audit", 
        %w( project_id dataset_name )) if $env == 'prod'


end


main()