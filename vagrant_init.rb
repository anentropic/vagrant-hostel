# This file is automatically loaded by Vagrant. We use this to kick-start
# our plugin.

begin
  require "vagrant"
rescue LoadError
  raise "The Vagrant Hostel plugin must be run within Vagrant."
end

require 'hostel/plugin'
