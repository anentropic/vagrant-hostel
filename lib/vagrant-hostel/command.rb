module VagrantHostel
  class Command < Vagrant.plugin(2, :command)
	  def execute
			options = {}
			options[:force] = false

			opts = OptionParser.new do |o|
			  o.banner = "Usage: vagrant hostel [vm-name] [no. to replicate]"
			  o.separator ""
			end

			# Parse the options
			argv = parse_options(opts)

	    puts "Hostel: #{argv}"
	    vm_name = argv[0]
	    multiple = argv[1]
	    puts "#{@env.methods}"

	    with_target_vms(vm_name) do |vm|
		    puts "#{vm.config.vm.host_name}"
		  end

	    0
		end
  end
end