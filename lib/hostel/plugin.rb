module VagrantHostel
	class Hostel < Vagrant::Command::Base
	  name "Hostel"

	  command "hostel" do
	    require_relative "command"
	    Command
	  end
	end
end