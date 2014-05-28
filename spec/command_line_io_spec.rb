require 'spec_helper'
require 'tic_tac_toe/command_line_io'
require 'tic_tac_toe/stringifier'

describe TicTacToe::CommandLineIO do
  let(:stringifier) { TicTacToe::Stringifier }
  let(:io) { TicTacToe::CommandLineIO }


  describe '#get_row_size' do
    it "asks for a row size" do
      valid_row_size = 3
      allow(io).to receive(:get_input) { valid_row_size }
      expect(io).to receive(:ask_for_row_size)
      io.get_row_size
    end

    it "solicits row size input" do
      valid_row_size = 3
      allow(io).to receive(:ask_for_row_size)
      expect(io).to receive(:get_input) { valid_row_size }
      io.get_row_size
    end

    it "only returns a row size once it receives an integer-like string" do
      not_integer_like, integer_like = "string", 10
      allow(io).to receive(:ask_for_row_size)
      allow(io).to receive(:get_input).and_return(not_integer_like, integer_like)
      expect(io.get_row_size).to eql(integer_like)
    end
  end


  describe '#ask_for_row_size' do
    it "asks for a stringified row size solicitation message" do
      expect(stringifier).to receive(:row_size_solicitation)
      io.ask_for_row_size
    end
  end


  describe '#get_token' do
    let(:token) { "X" }
    let(:player) { double("player") }

    it "asks for a token" do
      allow(io).to receive(:get_input) { token }
      expect(io).to receive(:ask_for_token).with(player)
      io.get_token(player)
    end

    it "solicits token input" do
      allow(io).to receive(:ask_for_token)
      expect(io).to receive(:get_input) { token }
      io.get_token(player)
    end

    it "converts the input into a symbol" do
      allow(io).to receive(:get_input) { token }
      allow(io).to receive(:ask_for_token)
      expect(io.get_token(player)).to equal(:X)
    end
  end


  describe '#ask_for_token' do
    it "asks for a stringified token solicitation message" do
      player = :human
      expect(stringifier).to receive(:token_solicitation).with(player)
      io.ask_for_token(player)
    end
  end


  describe '#get_difficulty' do
    let(:difficulty) { "medium" }

    it "asks for a difficulty" do
      allow(io).to receive(:get_input) { difficulty }
      expect(io).to receive(:ask_for_difficulty)
      io.get_difficulty
    end

    it "solicits difficulty input" do
      allow(io).to receive(:ask_for_difficulty)
      expect(io).to receive(:get_input) { difficulty }
      io.get_difficulty
    end

    it "converts the input into a symbol" do
      allow(io).to receive(:get_input) { difficulty }
      allow(io).to receive(:ask_for_difficulty)
      expect(io.get_difficulty).to equal(:medium)
    end
  end


  describe '#ask_for_difficulty' do
    it "asks for a stringified difficulty solicitation message" do
      expect(stringifier).to receive(:difficulty_solicitation)
      io.ask_for_difficulty
    end
  end


  describe '#make_move' do
    let(:board) { double("board") }
    let(:players) { double("players") }

    it "asks for a move" do
      valid_move = 0
      allow(io).to receive(:get_input) { valid_move }
      expect(io).to receive(:ask_for_move)
      io.make_move(board, players)
    end

    it "solicits move input" do
      valid_move = 0
      allow(io).to receive(:ask_for_move)
      expect(io).to receive(:get_input) { valid_move }
      io.make_move(board, players)
    end

    it "only returns a move once it receives an integer-like string" do
      not_integer_like, integer_like = "string", 100
      allow(io).to receive(:ask_for_move)
      allow(io).to receive(:get_input).and_return(not_integer_like, integer_like)
      expect(io.make_move(board, players)).to eql(integer_like)
    end
  end


  describe '#ask_for_move' do
    it "asks for a stringified move solicitation message" do
      expect(stringifier).to receive(:move_solicitation)
      io.ask_for_move
    end
  end


  describe '#say_game_over' do
    it "asks for a stringified game over message" do
      winner = :O
      expect(stringifier).to receive(:game_over_notification).with(winner)
      io.say_game_over(winner)
    end

    it "passes 'Nobody' if there is no winner" do
      winner = nil
      winner_string = "Nobody"
      expect(stringifier).to receive(:game_over_notification).with(winner_string)
      io.say_game_over(winner)
    end
  end


  describe '#draw_board' do
    it "asks for a stringified representation of a board" do
      board = double("board")
      expect(stringifier).to receive(:board).with(board)
      io.draw_board(board)
    end
  end
end
