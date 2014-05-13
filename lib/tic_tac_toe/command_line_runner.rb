module TicTacToe
  class CommandLineRunner
    def initialize(game, computer, io)
      @game = game
      @computer = computer
      @io = io
    end

    def play
      @io.draw_board
      if Rules.game_over?(@game.tokens, @game.board)
        @io.say_game_over(Rules.determine_winner(@game.tokens, @game.board))
      else
        @game.tokens.first == :X ? @io.send_move : @game.make_move(@computer.make_move)
        play
      end
    end
  end
end
