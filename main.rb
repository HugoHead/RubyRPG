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
		if resposnse.to_i == i
			isInt = true
			break
		end
	end

	puts (isInt)

	if isInt
		return options[resposnse]
	else
		return select(options)
	end
end

class Player
	attr_accessor :archi, :name,	

	def determineArchi
		return select(["rouge", "mage", "brute"])
	end

	def initialize
		puts "Welcome to a text adventure!"
		puts "What is your name?"
		name = gets.chomp("\n")
		self.name = name
		puts "Hello #{self.name}."

		self.archi = determineArchi

		puts self.archi
	end
end

$user = Player.new

puts select(["rouge", "mage", "brute"])