# frozen_string_literal: true

# This  module file is responsible for serializing/deserializing game data so that it can be used by save_file class.
module SerializeDeserialize
  module_function

  # This method serilaizes the data into a specified format.
  def serialize(data, format = :json)
    case format
    when :json
      require 'json'
      JSON.dump(data)
    when :yaml
      require 'yaml'
      YAML.dump(data)
    else
      raise ArgumentError, "Unsupported serizalization format: #{format}"
    end
  rescue StandardError => e
    raise SerializationError, "Failed to serialize data: #{e.message}"
  end

  def deserialize(string, format = :json)
    case format
    when :json
      require 'json'
      JSON.parse(string)
    when :yaml
      require 'yaml'
      YAML.safe_load(string)
    else
      raise ArgumentError, "Unsupported deserialization format: #{format}"
    end
  rescue StandardError => e
    raise DeserializationError, "Failed to deserialize data: #{e.message}"
  end

  # Custom error classes for serialization and deserialization errors
  class SerializationError < StandardError; end
  class DeserializationError < StandardError; end
end
