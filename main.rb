require 'colorize'

def pause
	print("press enter to coninue")
	gets
end

def handle(option)
	if option == "run"
		puts "You run from #{$currentEnemy.amnimateEnemyName} and away from #{$currentEnemy.location}."
	elsif option == "punch"

	elsif option == "cast"

	elsif option == "sneak"

	elsif option == "lift"
	
	elsif option == "persuade"

	end	
end

def select (name, options)
	puts "\n#{name}".blue

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
	attr_accessor :archi, :name, :classAttrs, :availableOptions
	def determineArchi
		return select("pick a class", ["rouge", "mage", "brute"])
	end

	def initialize
		self.availableOptions  = ["run", "punch", "persuade"]	
		puts "Welcome to a text adventure!".green
		puts "What is your name?".green
		name = gets.chomp("\n")
		self.name = name
		puts "Hello #{self.name}.".green
	end
end

$user = Player.new

$user.archi = select("Pick a class", ["rouge", "mage", "brute"])

if $user.archi == "mage"
	$user.availableOptions.push("cast")
elsif $user.archi == "rouge"
	$user.availableOptions.push("sneak")
elsif $user.archi == "brute"
	$user.availableOptions.push("lift")
end

$currentEnemy = Chalange.new "rival", "your rival", "1", "the cave", "You enter a cave. The cave contians a rival member of your class."

gameRunning = true

while gameRunning == true
	pause
	option = select("Pick an option", $user.availableOptions)
	pause
	handle(option)
end