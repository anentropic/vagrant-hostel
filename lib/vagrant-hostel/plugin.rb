module VagrantHostel
  class MyPlugin < Vagrant.plugin("2")
    name "Hostel"

    command "hostel" do
      require_relative "command"
      Command
    end
  
    config "hostel" do
      require_relative "config"
      HostelVMConfig
    end
  end
end