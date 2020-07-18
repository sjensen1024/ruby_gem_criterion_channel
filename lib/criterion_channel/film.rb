class CriterionChannel::Film
	attr_reader :country, :director, :img, :title, :year

	def initialize(args)
		args.each do |k,v|
	      	instance_variable_set("@#{k}", v)
	    end
	end

end