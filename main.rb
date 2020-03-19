require 'colorize'

def pause
	print("press enter to coninue".cyan)
	gets
end

def run 
	if $user.currentLevel == 0
		puts "You turn to run. As you turn you see a massive brick wall that has been summond by the rival. You turn back to see him grinning."
	end
end

def punch

end 

def cast

end

def sneak
	arr = ["to", "away"]
	select "Sneak toards or away from the situation?"
end

def lift

end

def persuade

end

def handle(option)
	if option == "run"
		run
	elsif option == "punch"
		punch
	elsif option == "cast"
		cast
	elsif option == "sneak"
		sneak
	elsif option == "lift"
		lift
	elsif option == "persuade"
		persuade
	end	
end

def select (name, options)
	puts "\n#{name}".green

	i = 1
	options.each do |n|
		puts (i.to_s + ") " + n).red
		i += 1
	end
	puts "\n"

	resposnse = gets.chomp("\n")

	isInt = false

	i.times do |m|
		if resposnse.to_i == 0
			break
		end
		if resposnse.to_i == m
			isInt = true
			break
		end
	end

	puts "\n"

	if isInt
		return options[resposnse.to_i - 1]
	else
		return select(name, options)
	end
end

def changeLevel (amm)
	level = $user.currentLevel
	level += amm

				     #name,          threatname,      chalangeLevel,      locationName,      description
	levelZero = 	
		Chalange.new "rival enemy",  "rival",         1,                  "caveEntrance",      "You see a cave. The cave contians a rival of yours."

	levels = [
		levelZero
	]
	$user.currentLevel += amm
	return levels[level]
end

class Chalange
	attr_accessor :nAme, :amnimateEnemyName, :location, :chalangeLevel, :description
	def initialize (nAme, amnimateEnemyName, chalangeLevel, location, description)
		self.nAme = nAme
		self.amnimateEnemyName = amnimateEnemyName
		self.chalangeLevel = chalangeLevel
		self.location = location
		self.description = description
	end
end

class Player
	attr_accessor :archi, :name, :classAttrs, :availableOptions, :energy, :currentLevel

	def initialize
		self.energy = 100
		self.currentLevel = 0
		self.availableOptions  = ["run", "punch", "persuade", "cast"]	
		puts "Welcome to a text adventure!".green
		puts "What is your name?".green
		name = gets.chomp("\n")
		self.name = name
		puts "Hello #{self.name}.\n".green
	end
end

$user = Player.new

$chalange = changeLevel(0)

gameRunning = true

while gameRunning == true
	puts $chalange.description.green
	pause
	option = select("Pick an option", $user.availableOptions)
	pause
	handle(option)
end