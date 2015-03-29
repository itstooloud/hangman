#is the puzzle solved?
#is every letter in word also in guesses

def solved? (guesses, word)
	solved = true
	hits =  []
	word.length.times do |i|
		hits << word[i]
	end
	hits.each do |hit|
		unless guesses.include? hit
			solved = false
		end
	end
	solved


	
end

#puts solved?(['H','Y','A','L','M', "N"], "HYMNAL")