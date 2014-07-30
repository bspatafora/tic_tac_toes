require 'tic_tac_toes/core/rules'

module TicTacToes
  module Core
    module MoveStrategies
      module HardAI
        ALPHA, BETA = -1, 1

        def self.move(game_state)
          board = game_state.board

          return 0 if nine_board_first_move?(board)
          return second_move(board) if nine_board_second_move?(board)

          open_spaces = Hash[board.open_spaces.map { |space| [space, nil] }]

          open_spaces.each do |space, score|
            score = minimax(generate_game_state(space, game_state), :min, ALPHA, BETA)
            open_spaces[space] = score
          end

          best_score = open_spaces.values.max
          open_spaces.each { |space, score| return space if score == best_score }
        end

        private

        def self.minimax(game_state, current_player, alpha, beta)
          return score(game_state) if game_state.game_over?

          if current_player == :max
            game_state.board.open_spaces.each do |space|
              alpha = [alpha, minimax(generate_game_state(space, game_state), :min, alpha, beta)].max
              break if beta <= alpha
            end
            alpha
          elsif current_player == :min
            game_state.board.open_spaces.each do |space|
              beta = [beta, minimax(generate_game_state(space, game_state), :max, alpha, beta)].min
              break if beta <= alpha
            end
            beta
          end
        end

        def self.generate_game_state(space, game_state)
          new_game_state = Marshal.load(Marshal.dump(game_state))
          new_game_state.place_move(space)
          new_game_state.turn_over([])
          new_game_state
        end

        def self.score(game_state)
          winner = game_state.determine_winner
          if winner.nil?
            0
          elsif winner.move_strategy == self
            1
          else
            -1
          end
        end

        def self.nine_board_first_move?(board)
          board.size == 9 && board.open_spaces.count == 9
        end

        def self.nine_board_second_move?(board)
          board.size == 9 && board.open_spaces.count == 8
        end

        def self.second_move(board)
          if nine_board_corner_occupied(board) || nine_board_side_occupied(board)
            4
          elsif nine_board_center_occupied(board)
            0
          end
        end

        def self.nine_board_corner_occupied(board)
          board.space(0) || board.space(2) || board.space(6) || board.space(8)
        end

        def self.nine_board_side_occupied(board)
          board.space(1) || board.space(3) || board.space(5) || board.space(7)
        end

        def self.nine_board_center_occupied(board)
          board.space(4) ? true : false
        end
      end
    end
  end
end