class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]
  attr_accessor :guess_word, :attempted_chars, :remaining_incorrect_guesses

  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def already_attempted?(char)
    return true if @attempted_chars.include?(char.downcase)
    false
  end

  def get_matching_indices(char)
    matching_indices = []
    if !@secret_word.include?(char.downcase)
      return []
    else
      @secret_word.each_char.with_index do |c, i|
        if c == char.downcase
          matching_indices << i 
        end
      end
    end
    matching_indices
  end

  def fill_indices(char, indices)
    indices.each do |i|
      @guess_word[i] = char.downcase
    end
  end

  def try_guess(char)
    if already_attempted?(char.downcase)
      p 'that has already been attempted'
      return false
    else
      @attempted_chars << char
      @remaining_incorrect_guesses -= 1 if get_matching_indices(char.downcase) == []
      fill_indices(char.downcase, get_matching_indices(char.downcase))
      return true
    end
  end

  def ask_user_for_guess
    p 'Enter a char:'
    char = gets.chomp
    try_guess(char.downcase)
  end

  def win?
    if @guess_word.join == @secret_word
      print 'WIN'
      return true
    else
      false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      print 'LOSE'
      return true
    else
      false
    end
  end

  def game_over?
    if win? || lose?
      print @secret_word
      return true
    else
      false
    end
  end

end
