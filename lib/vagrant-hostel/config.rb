module VagrantHostel
  class HostelVMConfig < VagrantPlugins::Kernel_V2::VMConfig
    def initialize
      super
      @__stock = 1
    end

    def stock= val
      @__stock = val
    end

    def stock
      @__stock
    end
  end
end