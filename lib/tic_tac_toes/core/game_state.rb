require 'tic_tac_toes/core/rules'
require 'tic_tac_toes/core/move_strategies/types'

module TicTacToes
  module Core
    class GameState
      attr_writer :history
      attr_reader :board, :players

      def initialize(board, players, history)
        @board = board
        @players = players
        @history = history
      end

      def start_game
        record_board_size
        record_difficulty
      end

      def place_move(space)
        @board.place(current_player, space)
      end

      def current_player
        @players.first
      end

      def next_player
        @players[1]
      end

      def computer_player
        @players.detect { |player| player.move_strategy.type == MoveStrategies::COMPUTER }
      end

      def turn_over(move)
        @history.record_move(move) unless move.nil?
        @players.rotate!
      end

      def moves
        @history.moves
      end

      def end_game(winner)
        @history.record_winner(winner)
        @history.persist
      end

      def game_over?
        Rules.game_over?(@board, @players)
      end

      def determine_winner
        Rules.determine_winner(@board, @players)
      end

      def marshal_dump
        [@board, @players]
      end

      def marshal_load(array)
        @board, @players = array
      end

      private

      def record_board_size
        @history.record_board_size(@board.size)
      end

      def record_difficulty
        @history.record_difficulty(computer_player.move_strategy)
      end
    end
  end
end
