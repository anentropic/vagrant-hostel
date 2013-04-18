module VagrantHostel
  class Command < Vagrant::Command::Base
	  def execute
			options = {}
			options[:force] = false

			opts = OptionParser.new do |o|
			  o.banner = "Usage: vagrant hostel [vm-name] [no. to replicate]"
			  o.separator ""
			end

			# Parse the options
			argv = parse_options(opts)

	    puts "Hello: #{argv}"
	    0
		end
  end
end