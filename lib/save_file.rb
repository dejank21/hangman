# frozen_string_literal: true

require_relative 'serialize_deserialize'

# This class is responsible for saving and loading game data utlizing the SerializeDeserialize module.
# It also only allows one save file to be created at a time.
class SaveFile
  SAVE_FILENAME = 'hangman_save.json'

  def initialize(save_dir = nil, format = :json)
    @format = format
    @save_dir = save_dir || '.'
    Dir.mkdir(@save_dir) unless Dir.exist?(@save_dir)
  end

  def save_path
    File.join(@save_dir, SAVE_FILENAME)
  end

  def save_game(word, guessed_letters, incorrect_guesses)
    # Check with object in game_logic.rb if a save file already exists
    return [:existing_save, nil] if save_exists?

    # Here we'll create a hash with the game data
    game_data = {
      'word' => word,
      'guessed_letters' => guessed_letters,
      'incorrect_guesses' => incorrect_guesses,
      'timestamp' => Time.now.to_s
    }

    # Now we serialize the game data
    begin
      serialized_data = SerializeDeserialize.serialize(game_data, @format)

      # Write the serialized data to a file
      File.open(SAVE_FILENAME, 'w') do |file|
        file.write(serialized_data)
      end
      # Used to handle [status, error] as provided when called in the game_logic class
      [:success, nil]
    rescue SerializeDeserialize::SerializationError, IOError => e
      [:error, e]
    end
  end

  def load_game
    # Checks if object in game_logic.rb has a save file assosiated with it
    return [:no_save, nil] unless save_exists?

    begin
      serialized_data = File.read(SAVE_FILENAME)
      # After reading the file, we deserialize the data
      game_data = SerializeDeserialize.deserialize(serialized_data, @format)

      # Return the game_data
      [:success, game_data]
    rescue SerializeDeserialize::DeserializationError, IOError => e
      [:error, e]
    end
  end

  def save_exists?
    # Check if the save file exists
    File.exist?(SAVE_FILENAME)
  end

  def delete_save
    return [:no_save, nil] unless save_exists?

    begin
      File.delete(SAVE_FILENAME)
      [:success, nil]
    rescue IOError => e
      [:error, e]
    end
  end
end
