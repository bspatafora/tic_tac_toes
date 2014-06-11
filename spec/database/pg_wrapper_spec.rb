require 'database/pg_wrapper'
require 'tic_tac_toe/spec_helper'

describe Database::PGWrapper do
  database = "test"
  let(:pg_wrapper) { Database::PGWrapper.new(database) }

  describe '#record_game' do
    it "sends a history object using the pg gem" do
      history = TicTacToe::History.new
      history.record_board_size(9)
      history.record_move(["X", 1])
      history.record_move(["O", 4])
      history.record_winner("X")

      expect { pg_wrapper.record_game(history) }.not_to raise_error
    end
  end

  describe '#parse_for_database' do
    it "returns a string based on a moves array" do
      moves = [["X", 1], ["O", 4]]
      moves_string = pg_wrapper.parse_for_database(moves)

      expect(moves_string).to eq("X1O4")
    end
  end
end