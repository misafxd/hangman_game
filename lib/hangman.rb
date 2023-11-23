puts 'Welcome to Hangman Game!!'

# Hangman game The Odin Project
class Game
  attr_accessor :word

  def initialize
    @player = Player.new
    @word = Word.new
    @guess_count = 0
    # puts @word.secret_word
    # puts @word.secret_word.size
  end

  def input
    loop do
      puts 'Type a char'
      @input = gets.chomp
      break if @input.match(/[a-zA-Z]/)
    end
    @input
  end
end

class Player
  def initialize
    @error = 0
    @tries = 6
  end
end

# Select a word randomly from the file google.txt
class Word
  attr_accessor :secret_word
  attr_reader :file

  def initialize
    @file = File.readlines 'google.txt'
    word_selection(@file)
  end

  def word_selection(file)
    loop do
      rand_line = rand(file.size)
      @secret_word = file[rand_line].chomp
      break if @secret_word.size >= 5 && @secret_word.size <= 12
    end
  end
end

Game.new

