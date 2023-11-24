puts 'Welcome to Hangman Game!!'

# Hangman game The Odin Project
class Game
  attr_accessor :word

  def initialize
    @word = Word.new
    @hangman = Hangman.new
    @guess_count = 0
    @guess_limit = 12
    @hidden_word = Array.new(@word.secret_word.size) { '_' }
    rules
    play
  end

  def rules
    puts "1. The objective of the game is to guess a hidden word, before the #{@guess_limit} allowed attempts"
    puts '2. A word is generated and kept hidden.'
    puts '3. The player is shown the number of letters in the word using underscores to represent each letter.'
    puts '4. The player proposes a letter in each turn.'
    puts '5. The proposed letter is revealed in all corresponding positions in the word if correct.'
    puts '6. If the letter is not in the word, one attempt is deducted from the allowed total'
    puts '7. The game ends when the player correctly guesses all the letters in the word or exhausts the 6 attempts.'
    puts '8. If the player runs out of attempts without guessing the word, they lose.'
    puts 'Guess the word'
  end

  def input
    loop do
      puts 'Type a char or and option: '
      puts '1. Save'
      puts '2. Load last game'
      puts '3. Exit'
      @input = gets.chomp
      break if @input.match(/[a-zA-Z1-3]/)
    end
    check_input(@input)
  end

  def check_input(input)
    case input
    when '1'
      @guess_count -= 1
      save_game
    when '2'
      load_game
    when '3'
      exit
    else
      input
    end
  end

  def guess_play
    @guess_count += 1
    puts "\nGuess number: #{@guess_count}"
    input
  end

  def correct_guess
    if @word.secret_word.include?(@input)
      @hidden_word.each_index do |index|
        @hidden_word[index] = @input if @word.secret_word[index] == @input
      end
    end
  end

  def game_status
    if @hidden_word.join == @word.secret_word
      puts 'You win!!!'
      puts "Secret word: #{@word.secret_word}"
      exit
    elsif @guess_count == @guess_limit
      puts 'You lose :( '
      puts "Secret word: #{@word.secret_word}"
      exit
    end
    play
  end

  def play
    puts "\n#{@hidden_word.join(' ')}"
    guess_play
    correct_guess
    game_status
  end

  def save_game
    puts 'Game saved'
    File.open('game', 'w+') { |file| file.puts to_s }
  end

  def load_game
    puts 'Game loaded'
    saved_game = File.read('game')
    game_state = Marshal.load(saved_game)
    restore_state(game_state)
  end

  def restore_state(state)
    @word, @guess_count, @hidden_word = state
    play
  end

  def to_s
    Marshal.dump([@word, @guess_count, @hidden_word])
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
      @secret_word = file[rand_line].chomp.downcase
      break if @secret_word.size >= 5 && @secret_word.size <= 12
    end
  end
end

# Display stick figure
class Hangman
  def initialize

  end
end

Game.new
