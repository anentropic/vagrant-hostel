module VagrantHostel
  class MyPlugin < Vagrant.plugin("2")
    name "Hostel"

    command "hostel" do
      require_relative "vagrant-hostel/command"
      Command
    end
  
    config "hostel" do
      require_relative "vagrant-hostel/config"
      HostelVMConfig
    end
  end
end