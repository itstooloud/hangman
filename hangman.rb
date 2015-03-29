=begin
	
You will be building a simple command line Hangman game where one player plays against the computer, but a bit more advanced. If you're unfamiliar with how Hangman works, see Wikipedia.

Download the 5desk.txt dictionary file from http://scrapmaker.com/.
When a new game is started, your script should load in the dictionary and randomly select a word between 5 and 12 characters long for the secret word.
You don't need to draw an actual stick figure (though you can if you want to!), but do display some sort of count so the player knows how many more incorrect guesses she has before the game ends. You should also display which correct letters have already been chosen (and their position in the word, e.g. _ r o g r a _ _ i n g) and which incorrect letters have already been chosen.
Every turn, allow the player to make a guess of a letter. It should be case insensitive. Update the display to reflect whether the letter was correct or incorrect. If out of guesses, the player should lose.
Now implement the functionality where, at the start of any turn, instead of making a guess the player should also have the option to save the game. Remember what you learned about serializing objects... you can serialize your game class too!
When the program first loads, add in an option that allows you to open one of your saved games, which should jump you exactly back to where you were when you saved. Play on!

	
=end

#there are 61,304 words in the file.
require './show_word'
require './solved'

def secret_word
	words = []

	dict = File.open("5desk.txt")
	#fill up our words array with everything from the dictionary between 5 and 12 characters
	dict.each do |line|
		#the 'strip' function removes the \r\n from the words
		words << line.strip if line.strip.length.between?(5,12)
	end

	secret_word = words[rand(words.length)].upcase #.split("").to_a
	
end


class Player
	attr_accessor :name, :guesses
	def initialize(name)
		@name = name
		@guesses = []
	end
end


class Game
	attr_accessor :word, :player

	def initialize
		@word = secret_word
		@player = Player.new("Burt")
	end

end


#Player gets 6 guesses, one each for head, torso, 2 arms and 2 legs
def render_score(misses)
	score_display = ""
	misses.times do
		score_display << "*"
	end
	
	"Limbs missing: " + score_display.ljust(6, "-")
	
end

def play_game
	
	game = Game.new
	#puts game.word
	game_over = false
	misses = 0
	puts "I'm thinking of a word with " + game.word.length.to_s + " letters."
	puts show_word(game.player.guesses, game.word)
	
	while !game_over 

			puts "Guess a letter! >>"
			guess = gets.chomp.upcase

			while game.player.guesses.include?(guess)
				puts "You've already guessed that!"
				puts "Guess a letter! >>"
				guess = gets.chomp.upcase
			end

			while guess.length > 1
				puts "That's too many letters!"
				puts "Guess a letter! >>"
				guess = gets.chomp.upcase
			end


			game.player.guesses << guess

			unless game.word.include? guess
				misses +=1
			end

			if solved?(game.player.guesses, game.word)
				game_over = true
				puts "YOU SOLVED IT!"
				puts game.word + "!"
				break
			end

			if misses == 6
				game_over = true
				puts "Oh no! You're out of guesses and now you're hanged!"
				puts "The word was " + game.word + "!"
				break
			end

			puts show_word(game.player.guesses, game.word) + "   " + render_score(misses)
			puts render_score(misses)

			#turns +=1
	end


end



play_game

#puts render_score(2)
#puts secret_word




























