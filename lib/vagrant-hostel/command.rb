module VagrantHostel
  class Command < Vagrant.plugin(2, :command)
 	  def execute
			options = {}
			options[:force] = false

			opts = OptionParser.new do |o|
			  o.banner = "Usage: vagrant hostel [vm-name] [stock (no. of instances)]"
			  o.separator ""
			end

			# Parse the options
			argv = parse_options(opts)

	    puts "Hostel GIT: #{argv}"
	    vm_name = argv[0]
	    stock = argv[1]
	    # TODO:
	    # raise exceptions if these don't exist

	    global_config = @env.instance_variable_get(:@config_global)

	    puts "> #{global_config.hostel.instance_variables.sort}"
	    puts ">> #{global_config.vm.defined_vm_keys}"
	    puts ">>> #{global_config.hostel.defined_vms}"
	    puts ">>>> #{@env.machine_names}"

	   	global_config.hostel.defined_vm_keys.each do |vm_name|
	   		puts "#{vm_name} > #{global_config.hostel.defined_vms[vm_name].options}"
	   	end

	   	# do we accept `stock` via Vagrantfile config or just via command?
	   	# if from command we need to persist stock value using something like
	   	# StateFile (json file) from plugins/commands/plugin

		  mw = ::Vagrant::Action::Builder.new.tap do |b|
        # we need to expand the VM definitions in our HostelVMConfig
        # and apply them to a VMConfig object
        # then we can use the EnvSet action to merge this config into the current environment

        # additionally we should halt/destroy unused VMs (*before* the above) if we have
        # reduced the number of multiples, to avoid orphanned VMs
      end
      runner = @env.action_runner

	    with_target_vms(vm_name) do |vm|
	      #runner.run(mw, :machine=>vm)
		  end

		  # return status:
	    0
		end
  end
end