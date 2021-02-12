class Athlete
	""" Superclass  Athlete """
	attr_accessor :name, :country, :event
	attr_reader :age, :pb
	
	def age=(value)
		""" writer method validate input """
		if value < 0
			raise "ERROR: age must be a positive value"
		end
		@age = value
	end
	
	def pb=(value)
		""" writer method validate input """
		if value < 0
			raise "ERROR: age must be a positive value"
		end
		@pb = value
	end
	
	def versus(competitor)
		puts "#{@name} beats #{competitor.name} at the #{@event}"
		puts "Meanwhile #{competitor.name} beats #{name} at #{competitor.event}"
	end
end

class Runner < Athlete
	""" subclass runner """
end

class Swimmer < Athlete
	""" subclass swimmer """
end

class Cyclist < Athlete
	""" subclass cyclist """
end
