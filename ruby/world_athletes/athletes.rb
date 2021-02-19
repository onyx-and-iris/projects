class Athlete
	""" Superclass  Athlete """
	attr_accessor :country, :event
	attr_reader :name_first, :name_last, :age, :pb
 
	def age=(value)
		""" writer method validate input """
		if value < 0
			raise "ERROR: age must be a positive value"
		end
		@age = value
	end
	
	def pb=(value)
		""" writer method validate input """
		if value.empty?
			raise "ERROR: pb cannot be blank!"
		end
		@pb = value
	end

	def name_first=(value)
		""" writer method validate input """
		if value.empty?
			raise "ERROR: Name cannot be blank string!"
		end
		@name_first = value
	end

	def name_last=(value)
		""" writer method validate input """
		if value.empty?
			raise "ERROR: Name cannot be blank string!"
		end
		@name_last = value
	end

	def initialize(name_first = "Default", name_last = "Name")
		""" alias to writer methods """
		self.name_first = name_first
		self.name_last = name_last
		self.event = "Unknown"
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
	def initialize(name_first = "Default", name_last = "Name", age = 0)
		""" call super with only name_first and name_last """
		super(name_first, name_last)
		self.age = age
	end

	def is_wanda
		puts "#{fullname} is a member of the Wanda Diamond League"
	end
end


class Cyclist < Athlete
	""" subclass cyclist """
	attr_reader :rank, :career_points, :team

	def team=(value)
		if value.empty?
			raise "ERROR Team cannot be blank string!"
		end
		@team = value
	end

	def self.ag2r(name_first, name_last)
		""" factory function """
		Cyclist.new(name_first, name_last, "AG2R La Mndoiale")
	end

	def self.ntt(name_first, name_last)
		""" factory function """
		Cyclist.new(name_first, name_last, "NTT Pro Cycling")
	end

	def self.trek(name_first, name_last)
		""" factory function """
		Cyclist.new(name_first, name_last, "Trek-Segafredo")
	end

	def initialize(name_first, name_last, team = "Default")
		""" call super with only name_first and name_last """
		super(name_first, name_last)
		self.team = team
	end

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

class Swimmer < Athlete
	attr_accessor :aggregate, :team, :stroke, :distance

	""" subclass swimmer """
	def team=(value)
		if value.empty?
			raise "ERROR Team cannot be blank string!"
		end
		@team = value
	end

	def self.lonr(name_first, name_last)
		""" factory function """
		Swimmer.new(name_first, name_last, "London Roar")
	end

	def self.nyb(name_first, name_last)
		""" factory function """
		Swimmer.new(name_first, name_last, "New York Breakers")
	end

	def self.oct(name_first, name_last)
		""" factory function """
		Swimmer.new(name_first, name_last, "OC Trident")
	end

	def initialize(name_first, name_last, team = "Default")
		""" call super with only name_first and name_last """
		super(name_first, name_last)
		self.team = team
	end

	def versus(competitor)
		""" method override """
		@distance, @stroke = @event.split()
		competitor.distance, competitor.stroke = competitor.event.split()

		if self.stroke.nil? || competitor.stroke.nil?
			puts("Comparing #{fullname} vs #{competitor.fullname}")
			puts("Event not known for one of the athletes")
		else
			super
		end
	end
end