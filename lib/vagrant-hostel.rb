module VagrantHostel
	class Hostel < Vagrant::Plugin::Base
	  name "Hostel"

	  command "hostel" do
	    require_relative "command"
	    Command
	  end
	end
end