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
end
