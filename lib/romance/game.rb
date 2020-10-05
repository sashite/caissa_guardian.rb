# frozen_string_literal: true

require "feen/parser"
require "ugoki/selector"

module Romance
  class Game
    def self.load(db, starting_position_feen)
      new(db, **::FEEN::Parser.call(starting_position_feen))
    end

    def initialize(db, **starting_position_params)
      @db = db

      @positions = [
        Position.new(**starting_position_params)
      ]
    end

    def play!(move)
      @positions << current_position.after(move) if legal?(move)
    end

    private

    def current_position
      @positions.fetch(-1)
    end

    def legal?(move)
      raise Error::InvalidPseudoLegalMove, move.inspect unless pseudo_legal_moves(current_position).include?(move)

      next_position = current_position.after(move)

      raise Error::RepetitionOfPosition, move.inspect if repetition?(next_position)
      raise Error::KingInCheck, move.inspect if in_check?(next_position)

      true
    end

    def repetition?(next_position)
      @positions.map(&:to_s).include?(next_position.to_s)
    end

    def in_check?(position)
      king_square_id = position.enemy_king_square_id
      return false if king_square_id.nil?

      next_pseudo_legal_moves = pseudo_legal_moves(position)

      next_pseudo_legal_moves.any? do |next_pseudo_legal_move|
        next_pseudo_legal_actions = next_pseudo_legal_move.each_slice(4)

        next_pseudo_legal_actions.any? do |next_pseudo_legal_action|
          next_pseudo_legal_action.fetch(1) == king_square_id
        end
      end
    end

    # @param position [Position] The state of the game.
    def pseudo_legal_moves(position)
      ::Ugoki::Selector.new(@db, position).call
    end
  end
end

require_relative "error"
require_relative "position"
