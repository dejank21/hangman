# frozen_string_literal: true

# This class is responsible for loading and displaying game art.
class GameArt
  def initialize
    @stage = [0, 1, 2, 3, 4, 5, 6]
  end

  HANGMAN_STAGES = [
    # Stage 0 (Start)
    "  +---+\n  |   |\n      |\n      |\n      |\n      |\n=========",

    # Stage 1 (Head)
    "  +---+\n  |   |\n  O   |\n      |\n      |\n      |\n=========",

    # Stage 2 (Body)
    "  +---+\n  |   |\n  O   |\n  |   |\n      |\n      |\n=========",

    # Stage 3 (One Arm)
    "  +---+\n  |   |\n  O   |\n /|   |\n      |\n      |\n=========",

    # Stage 4 (Both Arms)
    "  +---+\n  |   |\n  O   |\n /|\\  |\n      |\n      |\n=========",

    # Stage 5 (One Leg)
    "  +---+\n  |   |\n  O   |\n /|\\  |\n /    |\n      |\n=========",

    # Stage 6 (Complete - Game Over)
    "  +---+\n  |   |\n  O   |\n /|\\  |\n / \\  |\n      |\n========="
  ].freeze

  def display_stage(wrong_guesses)
    stage_index = [wrong_guesses.to_i, HANGMAN_STAGES.length - 1].min
    # The last valid index will always be length - 1. We use min to select the lesser value of the two possibilities.
    # This prevents us from going out of bounds by selecting a stage or capping the stage at the last index.
    current_stage = HANGMAN_STAGES[stage_index]
    puts current_stage
  end

  def display_word_progress(word, guessed_letters)
    # Creates a display of underscores for each unguessed letter
    display = word.chars.map do |char|
      guessed_letters.include?(char) ? char : '_'
    end.join(' ')

    puts "\nWord: #{display}"
  end

  def display_guessed_letters(guessed_letters, incorrect_guesses, max_incorrect_guesses)
    puts "\nLetters guessed: #{guessed_letters.sort}"
    # This is sorted alphabetically to make it easier to read.
    puts "Incorrect guesses: #{incorrect_guesses} / #{max_incorrect_guesses}"
  end

  def display_game_state(word, guessed_letters, incorrect_guesses, max_incorrect_guesses)
    puts "\n"
    display_stage(incorrect_guesses)
    display_word_progress(word, guessed_letters)
    display_guessed_letters(guessed_letters, incorrect_guesses, max_incorrect_guesses)
    puts "\n"
  end
end
