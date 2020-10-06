# frozen_string_literal: true

require "qi"
require "ugoki/position"

module CaissaGuardian
  # Position namespace.
  class Position < ::Ugoki::Position
    def after(move)
      hash = ::Qi.call(move, in_hand: in_hand, square: square)
      self.class.new(shape: shape, side_id: next_side_id, **hash)
    end

    def enemy_king_square_id
      enemy_pieces.each do |square_id, piece_name|
        break square_id if piece_name.include?("-")
      end
    end

    # The list of pieces on the board owned by the opponent player, with squares.
    #
    # @return [Hash] Top-side's pieces if turn to bottomside, bottom-side's ones
    #   otherwise.
    def enemy_pieces
      turn_to_topside? ? square_bottomside_pieces : square_topside_pieces
    end

    # @note Faster than FEEN to calculate.
    def to_s
      [
        side_id,
        square.keys.sort.inject("") { |s, key| s + "#{key}:#{square.fetch(key)}" },
        shape.join("x"),
        in_hand.join(",")
      ].join("--")
    end

    def next_side_id
      side_id.next % sides_count
    end

    def sides_count
      2
    end
  end
end
