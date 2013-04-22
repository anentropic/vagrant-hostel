module VagrantHostel
  class Config < Vagrant.plugin(2, :config)
    def initialize
      @__defined_vm_keys = []
      @__defined_vms = {}
      @replicants = 1
    end
  
    def finalize!
      (0..@replicants-1).each do |i|
        puts i
      end
    end

    # Below we mimic (i.e. copy & paste) functionality of Vagrant from:
    # VagrantPlugins::Kernel_V2::VMConfig
    #
    # The aim is to provide our own `define` method to use in place of
    # `config.vm.define`
    # -------

    DEFAULT_VM_NAME = :default

    def merge(other)
      super.tap do |result|
        # Merge defined VMs by first merging the defined VM keys,
        # preserving the order in which they were defined.
        other_defined_vm_keys = other.instance_variable_get(:@__defined_vm_keys)
        other_defined_vm_keys -= @__defined_vm_keys
        new_defined_vm_keys   = @__defined_vm_keys + other_defined_vm_keys

        # Merge the actual defined VMs.
        other_defined_vms = other.instance_variable_get(:@__defined_vms)
        new_defined_vms   = {}

        @__defined_vms.each do |key, subvm|
          new_defined_vms[key] = subvm.clone
        end

        other_defined_vms.each do |key, subvm|
          if !new_defined_vms.has_key?(key)
            new_defined_vms[key] = subvm.clone
          else
            new_defined_vms[key].config_procs.concat(subvm.config_procs)
            new_defined_vms[key].options.merge!(subvm.options)
          end
        end

        result.instance_variable_set(:@__defined_vm_keys, new_defined_vm_keys)
        result.instance_variable_set(:@__defined_vms, new_defined_vms)
      end
    end

    def defined_vms
      @__defined_vms
    end

    # This returns the keys of the sub-vms in the order they were
    # defined.
    def defined_vm_keys
      @__defined_vm_keys
    end

    def define(name, options=nil, &block)
      name = name.to_sym
      options ||= {}
      options[:config_version] ||= "2"

      # Add the name to the array of VM keys. This array is used to
      # preserve the order in which VMs are defined.
      @__defined_vm_keys << name if !@__defined_vm_keys.include?(name)

      # Add the SubVM to the hash of defined VMs
      if !@__defined_vms[name]
        @__defined_vms[name] = VagrantConfigSubVM.new
      end

      @__defined_vms[name].options.merge!(options)
      @__defined_vms[name].config_procs << [options[:config_version], block] if block
    end
  end
end