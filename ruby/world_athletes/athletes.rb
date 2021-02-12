class Athlete
	""" Superclass  Athlete """
	attr_accessor :name_first, :name_last, :country, :event
	attr_reader :age, :pb

	def age=(value)
		""" writer method validate input """
		if value < 0
			raise "ERROR: age must be a positive value"
		end
		@age = value
	end
	
	def pb=(value)
		if value < 0
			raise "ERROR: age must be a positive value"
		end
		@pb = value
	end

	def fullname
		"#{name_first} #{name_last}"
	end
	
	def versus(competitor)
		puts "#{fullname} beats #{competitor.fullname} at the #{@event}"
		puts "Meanwhile #{competitor.fullname} beats #{fullname}  at #{competitor.event}"
	end
end

class Runner < Athlete
	""" subclass runner """
	def isWanda
		puts "#{fullname} is a member of the Wanda Diamond League"
	end
end

class Swimmer < Athlete
	""" subclass swimmer """
end

class Cyclist < Athlete
	""" subclass cyclist """
	attr_accessor :team
	attr_reader :rank, :career_points

	def rank=(value)
		if value < 0
			raise "ERROR Rank must be positive integer"
		end
	end

	def career_points=(value)
		if value < 0
			raise ERROR "Career points must be positive integer"
		end
	end

	def bike(value)
		""" hash teams to bikes and implicitly return bikes for team """
		teams = {
			"AG2R La Mondiale" => "Eddy Merckx EM525 Disc, Stockeu69", 
		"NTT Pro Cycling" => "BMC Teammachine SLR,  Timemachine Road", 
		"Trek-Segafredo" => "Trek Emonda SLR, Madone SLR"
		}

		if teams.include? value  
			teams[value] 
		end
	end

	def team
		puts "#{fullname} is a member of #{@team}"
		puts "Their team rides bikes: #{bike(@team)}"
	end
end
