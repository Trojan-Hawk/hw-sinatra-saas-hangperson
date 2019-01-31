class HangpersonGame
  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.
  attr_accessor :word, :guesses, :wrong_guesses
  
  def guess c
    # if it is in the alphabet
    if c =~ /[[:alpha:]]/
      # downcase the input
      c.downcase!
      
      # if the word contains c or not
      if @word.include? c
        # if the same correct guess has not been made
        if !@guesses.include? c
          @guesses.concat c
        else
          return false
        end
      else
        # if the same wrong guess has not been made
        if !@wrong_guesses.include? c
          @wrong_guesses.concat c
        else
          return false
        end
      end
    else 
      # character is invalid
      raise ArgumentError
    end
  end
  
  def word_with_guesses
    result = ""
    
    # for each letter in word
    @word.each_char do |letter| 
     # if the letter is contained within @guesses
     if @guesses.include? letter
       result.concat letter
     else
       result.concat '-'
     end
    end
    
    return result
  end
  
  def check_win_or_lose
    # if guessed wrong 7 or more times
    return :lose if @wrong_guesses.length >= 7
    # count the number of letters matched between @guesses and @word
    counter = 0
    word.each_char do |letter|
      if @guesses.include? letter
        counter += 1
      end
    end
    
    # if each letter has been accounted for
    return :win if @word.length == counter
    # keep playing
    return :play
  end
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end

end
