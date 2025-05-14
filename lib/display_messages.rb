# frozen_string_literal: true

module DisplayMessages
  # Contains a module for all messages to be displayed to the user.
  def self.welcome_message
    puts "\n=========== HANGMAN ===========\n"
    puts 'Welcome to Hangman!'
    puts 'Try to guess the secret word before the man is hanged.'
    puts "Type a letter to guess, 'save' to save your game, or 'quit' to exit."
    puts "Good luck!\n"
    puts '==============================='
  end

  def self.prompt_for_action
    print "\nEnter a letter, 'save', or 'quit': "
  end

  def self.invalid_input
    puts "Invalid input. Please enter a single letter, 'save', or 'quit'."
  end

  def self.already_guessed(letter)
    puts "You've already guessed the letter '#{letter}'. Try another letter."
  end

  def self.correct_guess(letter)
    puts "Good guess! '#{letter}' is in the word."
  end

  def self.incorrect_guess(letter)
    puts "Sorry, '#{letter}' is not in the word."
  end

  # Game outcome messages
  def self.win(word)
    puts "\n🎉 Congratulations! 🎉"
    puts "You've correctly guessed the word: '#{word}'!"
    puts 'You saved the hangman!'
  end

  def self.lose(word)
    puts "\n💀 Game Over 💀"
    puts "The hangman couldn't be saved. The word was: '#{word}'."
    puts 'Better luck next time!'
  end

  # Save and load messages
  def self.saved_game_found
    print "\nA saved game was found. Would you like to load it? (Y/N): "
  end

  def self.game_loaded
    print "\nGame loaded successfully. Welcome back!\n"
  end

  def self.no_save_found
    puts "\nNo saved game found. Starting a new game."
  end

  def self.load_error(message)
    puts "\nError loading the game: #{message}"
    puts 'Starting a new game instead.'
  end

  def self.save_success
    puts "\nGame saved successfully!"
  end

  def self.save_exists_prompt
    print "\nA saved game already exists. Would you like to overwrite it? (Y/N): "
  end

  def self.save_error(message)
    puts "\nError saving the game: #{message}"
  end

  # Quit messages
  def self.save_before_quit
    print "\nWould you like to save your game before quitting? (Y/N): "
  end

  def self.goodbye
    puts "\nGoodbye! Thanks for playing Hangman!"
  end
end
