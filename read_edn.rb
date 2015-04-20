#!/usr/bin/env ruby

require 'edn'

edn_file = ARGV.first

EDN.register("resource-config/env") do |env_var|
  ENV[env_var]
end

File.open(edn_file) do |f|
  puts EDN.read(f).to_edn
end
