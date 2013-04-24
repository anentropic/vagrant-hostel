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
	    # TODO:
	    # raise exceptions if these don't exist

	    puts ">> #{@env.instance_variable_get(:@config_global).vm.instance_variable_get(:@__defined_vms)}"
	    puts ">> #{@env.instance_variable_get(:@config_global).vm.instance_variable_get(:@__defined_vm_keys)}"

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

	    0
		end
  end
end