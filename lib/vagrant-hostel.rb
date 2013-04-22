module VagrantHostel
  class Plugin < Vagrant.plugin("2")
    name "Hostel"

    command "hostel" do
      require_relative "vagrant-hostel/command"
      Command
    end
  
    config "hostel" do
      require_relative "vagrant-hostel/config"
      HostelVMConfig
    end

    action_hook "hostelize", :hook_name => 'config_validate' do
      puts "HOOK! Arrgh!"
    end
  end
end