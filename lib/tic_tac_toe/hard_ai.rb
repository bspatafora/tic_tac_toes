require 'tic_tac_toe/rules'

module TicTacToe
  module HardAI
    def self.make_move(board, players)
      own_token = players.first.token
      open_spaces = Hash[board.open_spaces.map { |space| [space, nil] }]

      open_spaces.each do |space, score|
        minimax_score = minimax(generate_board(own_token, space, board), :min, players)
        open_spaces[space] = minimax_score
      end

      open_spaces.each { |space, score| return space if score == open_spaces.values.max }
    end

    def self.minimax(board, current_player, players)
      own_token, opponent_token = players.first.token, players.last.token

      return score(board, players) if Rules.game_over?(players, board)

      if current_player == :max
        best_score = -1

        board.open_spaces.each do |space|
          score = minimax(generate_board(own_token, space, board), :min, players)
          best_score = [best_score, score].max
        end

        return best_score
      elsif current_player == :min
        best_score = 1

        board.open_spaces.each do |space|
          score = minimax(generate_board(opponent_token, space, board), :max, players)
          best_score = [best_score, score].min
        end

        return best_score
      end
    end

    def self.generate_board(token, space, board)
      new_board = Marshal::load(Marshal::dump(board))
      new_board.place(token, space)
      new_board
    end

    def self.score(board, players)
      own_token, opponent_token = players.first.token, players.last.token

      case Rules.determine_winner(players, board)
      when own_token
        1
      when opponent_token
        -1
      else
        0
      end
    end
  end
end
