class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
attr_accessor :word, :guesses, :wrong_guesses, :prevguesses, :word_with_guesses, :turns
	def initialize(word)
	    @word = word
	    @guesses = ""
	    @wrong_guesses= ""
	    @prevguesses = []
	    @word_with_guesses = ""
	    setup
	    @turns = 0
	end

	def setup
		@word.length.times {
			@word_with_guesses = @word_with_guesses + "-"
		}
	end

	def guess(input)
		# checking the input then (3) pushes the new input in array
		# (1)if input exists
		# (2)if input contains only letters
		if input == nil or not /^\s*[a-zA-Z]\s*$/.match(input)
			begin
				raise ArgumentError, "need a valid input"
			rescue
				input = ""
			end
		else
			input.downcase!
			if @prevguesses.include?(input)
		 		return false
			else 
				@prevguesses.push(input)
			end
		end
	
		# changing guesses/wrong_guesses
		if @word.include?(input)
			@guesses = input
			indexes = (0 ... @word.length).find_all { |i| @word[i,1] == input }
			for i in indexes
				@word_with_guesses[i] = input
			end
		else
			@turns +=1
			@wrong_guesses = @wrong_guesses + input
		end
		return true
	end

	def check_win_or_lose
		if not @word_with_guesses.include?("-")
			return :win
		elsif @turns > 6
			return :lose
		else
			return :play
		end
	end

	def check_if_invalid(theletter)
		if theletter == nil or not /^\s*[a-zA-Z]\s*$/.match(theletter)
			return true
		else
			return false
		end
	end



  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end


