#render hangman display based on letters hit and missed 

def show_word(guesses, word)

	display_word = []
	word.length.times do |l|
		if guesses.include? word[l]
			display_word << " " + word[l] + " "
		else
			display_word << " _ "
		end
	end
	display_word.join.strip
	
end

#puts show_word(['H','I','M', "N"], "HYHHAL")