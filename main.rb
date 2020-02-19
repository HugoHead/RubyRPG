def select (options)
	i = 1
	options.each do |n|
		puts i.to_s + ") " + n
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
		return select(options)
	end
end

class Mage
	attr_accessor :availableAttacks = ["run", "cast"]
	def initailize
		puts "You are now a mage. What would you like to do?"
	end
end

class Rouge
	
	def initialize
		puts "You are now a rouge.  What would you like to do?"
	end
end

class Brute
	def initialize
		puts "You are now a brute.  What would you like to do?"
	end
end

class Player
	attr_accessor :archi, :name, :classAttrs	

	def determineArchi
		return select(["rouge", "mage", "brute"])
	end

	def initialize
		puts "Welcome to a text adventure!"
		puts "What is your name?"
		name = gets.chomp("\n")
		self.name = name
		puts "Hello #{self.name}."
	end
end

$user = Player.new

$user.archi = select(["rouge", "mage", "brute"])

if $user.archi == "mage"
	classAttrs = Mage.new
elsif $user.archi == "rouge"
	classAttrs = Rouge.new
elsif $user.archi == "brute"
	classAttrs = Brute.new
end

puts "You approach a rival."

select($user.classAttrs.availableAttacks)
















