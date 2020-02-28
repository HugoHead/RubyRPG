require 'colorize'

def select (name, options)
	puts "\n#{name}".blue

	i = 1
	options.each do |n|
		puts (i.to_s + ") " + n).green
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

class Player
	attr_accessor :archi, :name, :classAttrs, :availableAttacks
	def determineArchi
		return select("pick a class", ["rouge", "mage", "brute"])
	end

	def initialize
		self.availableAttacks  = ["run", "punch"]	
		puts "Welcome to a text adventure!".green
		puts "What is your name?".green
		name = gets.chomp("\n")
		self.name = name
		puts "Hello #{self.name}.".green
	end
end

$user = Player.new

$user.archi = select("Pick a class", ["rouge", "mage", "brute"])

=begin
if $user.archi == "mage"
	classAttrs = Mage.new
elsif $user.archi == "rouge"
	classAttrs = Rouge.new
elsif $user.archi == "brute"
	classAttrs = Brute.new
end
=end
puts "You approach a rival.".green

puts $user.availableAttacks

select("Pick an option", $user.availableAttacks)
