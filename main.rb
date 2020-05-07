require 'colorize'

def pause
	print("press enter to coninue".cyan)
	gets
end

def look
	puts $chalange.description.green
end

def run 
	if $user.currentLevel == 0
		puts "You turn to run. As you turn you see a massive brick wall that has been summond by the rival. You turn back to see him grinning."
	end
end

def punch
	print "You attempt to punch the ".green + $chalange.amnimateEnemyName.green + ". ".green
	punchStrength = $user.energy * rand()
	punchDifficulty = $chalange.energy * rand()
	if punchStrength / 2 > punchDifficulty
		#critical hit
		print "You hit really hard.\n".green
		$chalange.energy -= punchStrength * 1.25
	elsif punchStrength > punchDifficulty
		#hit
		print "You hit.\n".green
		$chalange.energy -= punchStrength
	elsif punchStrength * 2 > punchDifficulty
		#no hit
		print "You missed.\n".green
	else
		#mistep
		print "You trip and fall.\n".green
		$user.energy -= punchDifficulty * 0.25
	end
end 

def cast

end

def sneak
	arr = ["to", "away"]
	select "Sneak toards or away from the situation?", arr
end

def lift

end

def persuade
	amnimateEnemyName = $chalange.amnimateEnemyName
	arr = ["deeculate conflict", "desctract " + $chalange.amnimateEnemyName, "attempt to end conflict", "recive money from " + amnimateEnemyName, "anger " + amnimateEnemyName]
	goal = select "With which goal?", arr
	arr = ["clever words", "threat", "bribe"]
	techneque = select "With what method?", arr
	succsess = false
	if (goal == "recive money from " + amnimateEnemyName && techneque == "bribe") || (goal == "deeculate conflict" && techneque == "clever words") || (goal == "attempt to end conflict" && techneque == "clever words")
		#super effective
		succsess = (rand() > 0.4)
	elsif (goal == "desctract " + amnimateEnemyName && techneque == "clever words") || (goal == "anger " + amnimateEnemyName && techneque == "clever words") || (goal == "anger " + amnimateEnemyName && techneque == "threat")
		#effective
		succsess = (rand() > 0.65)
	elsif (goal == "recive money from " + amnimateEnemyName && techneque == "clever words") || (goal == "desctract " + amnimateEnemyName && techneque == "bribe") || (goal == "attempt to end conflict" && techneque == "threat")
		#nutreal
		succsess = (rand() > 0.8)
	elsif (goal == "recive money from " + amnimateEnemyName && techneque == "threat") || (goal == "desctract " + amnimateEnemyName && techneque == "threat") || (goal == "attempt to end conflict" && techneque == "bribe")
		#under effective
		succsess = (rand() > 0.89)
	else 
		#useless
		succsess = false
	end

	if succsess
		if goal == "deeculate conflict"
			puts "the conflict was desculated"
		elsif goal == "desctract " + $chalange.amnimateEnemyName
			puts $chalange.amnimateEnemyName + " is desctracted"
		elsif goal == "attempt to end conflict"
			puts "conflict ended"
			changeLevel(1)
		elsif goal == "recive money from " + amnimateEnemyName
			puts "you got some money"
		elsif goal == "anger " + amnimateEnemyName
			puts amnimateEnemyName + " is now more angry"
		end
	else
		puts "you fail"
	end
			
end

def handle(option)
	if option == "run"
		run
	elsif option == "look"
		look
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
	puts "level changing"
	level = $user.currentLevel
	level += amm

				     #name,          threatname,      chalangeLevel,      locationName,      description
	levelZero = 	
		Chalange.new "rival enemy",  "rival",         1,                  "caveEntrance",      "You see a cave. The cave contians a rival of yours."
	levelOne = 	
		Chalange.new "rival enemy",  "rival",         2,                  "caveEntrance",      "You see a cave. The cave contians a rival of yours."

	levels = [
		levelZero
		levelOne
	]
	$user.currentLevel += amm
	return levels[level]
end

class Chalange
	attr_accessor :nAme, :amnimateEnemyName, :location, :chalangeLevel, :description, :energy
	def initialize (nAme, amnimateEnemyName, chalangeLevel, location, description)
		self.nAme = nAme
		self.amnimateEnemyName = amnimateEnemyName
		self.chalangeLevel = chalangeLevel
		self.location = location
		self.description = description
		self.energy = 100 * (chalangeLevel + 1) 
	end
end

class Player
	attr_accessor :archi, :name, :classAttrs, :availableOptions, :energy, :currentLevel

	def initialize
		self.energy = 100
		self.currentLevel = 0
		self.availableOptions  = ["look", "run", "punch", "persuade", "cast"]	
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

staggingLevel = $chalange.chalangeLevel - 1

while gameRunning == true
	#only continue if the threat is still in place
	if $chalange.energy <= 0
		puts "you moved to the next level."
		$chalange = chalangeLevel(1)
	end

	#check if the description for the current level has been displayed yet
	if staggingLevel != $chalange.chalangeLevel
		puts $chalange.description.green
		staggingLevel = $chalange.chalangeLevel
	end


	pause
	option = select("Pick an option", $user.availableOptions)
	pause
	handle(option)
ended