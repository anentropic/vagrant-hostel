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

    action_hook :echo, :environment_load do |hook|
      puts "ENVIRONMENT LOAD"
      mw = ::Vagrant::Action::Builder.new.tap do |b|
        b.use VagrantHostel::EchoAction
      end
      hook.append(mw)
    end
  end

  class EchoAction
    def initialize(app, env)
      @app = app
    end

    def call(env)
      env[:ui].info("EchoAction before!")
      @app.call(env)
      env[:ui].info("EchoAction after!")
    end
  end
end