# frozen string literal: true

# This class is responsible for choosing a random word from a file of 10,000 words between 5 and 12 characters.
module ChooseWord
  def self.random_word(min_length = 5, max_length = 12)
    file_path = File.join(File.dirname(__FILE__), 'words.txt')

    valid_words = File.readlines(file_path)
                      .map(&:strip)
                      .map(&:upcase)
                      .select { |word| word.length.between?(min_length, max_length) }

    # Return a random word from the valid words
    valid_words.sample
  end
end
