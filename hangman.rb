# frozen_string_literal: true

require_relative 'lib/game_logic'
require_relative 'lib/save_file'
require_relative 'lib/display_messages'

# This file contains the intergrated game logic as well as the user interface.
# I also include display messages to explain fuctions to the user.

# First we ensure that the saved_games directory exists
saved_games_dir = File.join(File.dirname(__FILE__), 'saved_games')
Dir.mkdir(saved_games_dir) unless Dir.exist?(saved_games_dir)

# Here we initialize the game and mangage save files
game = GameLogic.new
save_file = SaveFile.new(saved_games_dir)

# Check to see if there are any saved games.
def check_for_saved_games(save_file, game)
  if save_file.save_exists?
    DisplayMessages.saved_game_found
    response = gets.chomp.upcase

    if response == 'Y'
      load_saved_game(save_file, game)
    else
      game.new_game
    end
  else
    game.new_game
  end
end

def load_saved_game(save_file, game)
  # This method loads the saved game data and updates the game state.
  status, data_or_error = save_file.load_game

  case status
  when :success
    game.load_game_state(data_or_error)
    DisplayMessages.game_loaded
  when :no_save
    DisplayMessages.no_save_found
    game.new_game
  end
end

def save_current_game(save_file, game)
  # This method saves the current game state.
  status, error = save_file.save_game(
    game.word,
    game.guessed_letters,
    game.incorrect_guesses
  )

  case status
  when :success
    DisplayMessages.save_success
  when :existing_save
    DisplayMessages.save_exists_prompt
    response = gets.chomp.upcase

    if response == 'Y'
      save_file.delete_save
      new_status, new_error = save_file.save_game(
        game.word,
        game.guessed_letters,
        game.incorrect_guesses
      )

      if new_status == :success
        DisplayMessages.save_success
      else
        DisplayMessages.save_error(new_error.message)
      end
    end
  when :error
    DisplayMessages.save_error(error.message)
  end
end

def get_player_action
  # This method prompts the user to input Save, Quit/Exit or input a letter.
  DisplayMessages.prompt_for_action
  input = gets.chomp.upcase

  case input
  when 'SAVE'
    :save
  when 'QUIT', 'EXIT'
    :quit
  when /^[A-Z]$/
    [:guess, input]
  else
    DisplayMessages.invalid_input
    get_player_action
    # Recursively call the method until a valid input is received.
  end
end

def handle_guess_result(result, letter, word)
  # This method handles the result of the player's guess.
  case result
  when :already_guessed
    DisplayMessages.already_guessed(letter)
  when :correct
    DisplayMessages.correct_guess(letter)
  when :incorrect
    DisplayMessages.incorrect_guess(letter)
  when :win
    DisplayMessages.win(word)
  when :lose
    DisplayMessages.lose(word)
  end
end

def handle_quit(save_file, game)
  # This method provides a prompt to save the game before quitting.
  DisplayMessages.save_before_quit
  response = gets.chomp.upcase

  save_current_game(save_file, game) if response == 'Y'

  DisplayMessages.goodbye
  exit
end

def play_game(game, save_file)
  DisplayMessages.welcome_message

  until game.game_over
    game.display_game_state
    action = get_player_action

    case action
    when :save
      save_current_game(save_file, game)
    when :quit
      handle_quit(save_file, game)
    when Array
      # This handles an array with both action[0] and action[1] were 0 = :guess and 1 = letter
      # It first confirms that it's a letter guess then passes the letter via the second array value
      # to the guess_letter method.
      # A type of tagged union? Need to look into this.
      if action[0] == :guess
        result = game.guess_letter(action[1])
        handle_guess_result(result, action[1], game.word)
      end
    end
  end

  game.display_game_state

  if game.game_won
    DisplayMessages.win(game.word)
  else
    DisplayMessages.lose(game.word)
  end
end

check_for_saved_games(save_file, game)
play_game(game, save_file)
# This is the main game loop where the game is played.
