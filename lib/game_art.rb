# frozen_string_literal: true

# This class is responsible for loading and displaying game art.

class GameArt
  def initialize
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
  ]

  def display_hangman(stage)
  end
end
