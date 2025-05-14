# frozen_string_literal: true

# This file contains the game logic for the Hangman game.
require_relative 'game_art'
require_relative 'choose_word'
require_relative 'save_file'

# This class ties together all other classes and modules to run the core gameplay loop
class GameLogic
  attr_reader :word, :guessed_letters, :incorrect_guesses, :max_incorrect_guesses, :game_over, :game_won

  def initialize
    # Create instances of game_art and save_file.
    @game_art = GameArt.new
    @word = ''
    @guessed_letters = []
    @incorrect_guesses = 0
    @max_incorrect_guesses = 6
    @game_over = false
    @game_won = false
  end

  def new_game
    @word = ChooseWord.random_word
    @guessed_letters = []
    @incorrect_guesses = 0
    @game_over = false
    @game_won = false
  end

  def guess_letter(letter)
    letter = letter.upcase
    # Check if the letter has already been guessed
    return :already_guessed if @guessed_letters.include?(letter)

    # Add letter to guessed letters
    @guessed_letters << letter
    # Check if the letter is in the word
    if @word.include?(letter)
      # Check if the player has won
      if word_guessed?
        @game_won = true
        @game_over = true
        return :win
      end
      :correct
    else
      # Increment incorrect guesses and see if the game is over/lost
      @incorrect_guesses += 1
      if @incorrect_guesses >= @max_incorrect_guesses
        @game_over = true
        return :lose
      end
      :incorrect
    end
  end

  def word_guessed?
    # Check if all letters in the word have been guessed
    @word.chars.all? { |char| @guessed_letters.include?(char) }
  end

  def display_game_state
    # Display the current game state using the GameArt class
    @game_art.display_game_state(@word, @guessed_letters, @incorrect_guesses, @max_incorrect_guesses)
  end

  def load_game_state(save_data)
    # Use this method to load the game state from a save file.
    # I also utilize strings to avoid extra conversion with object serialization.
    @word = save_data['word']
    @guessed_letters = save_data['guessed_letters']
    @incorrect_guesses = save_data['incorrect_guesses']
    @game_over = false
    @game_won = false
  end

  def get_game_state
    # This method grabs the current game state for saving.
    {
      'word' => @word,
      'guessed_letters' => @guessed_letters,
      'incorrect_guesses' => @incorrect_guesses,
      'timestamp' => Time.now.to_s
    }
  end
end
