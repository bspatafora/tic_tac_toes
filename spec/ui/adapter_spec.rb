require 'tic_tac_toes/board'
require 'tic_tac_toes/game_state'
require 'tic_tac_toes/player_factory'
require 'ui/adapter'

describe UI::Adapter do
  describe '#new_board_structure' do
    it 'returns a new board structure' do
      new_board_structure = [nil, nil, nil, nil, nil, nil, nil, nil, nil]
      expect(UI::Adapter.new_board_structure).to eq(new_board_structure)
    end
  end

  describe '#move_made' do
    it 'takes a move (as string) and a board structure and returns an updated board structure' do
      board_structure = ["X", nil, nil, nil, "O", nil, nil, nil, nil]
      move = "2"
      updated_board_structure = ["X", "O", "X", nil, "O", nil, nil, nil, nil]

      expect(UI::Adapter.move_made(board_structure, move)).to eq(updated_board_structure)
    end
  end

  describe '#game_state_from_board_structure' do
    it 'returns a game state object based on a board structure' do
      board_structure = [nil, nil, nil, nil, "X", nil, nil, nil, nil]

      game_state = UI::Adapter.game_state_from_board_structure(board_structure)
      middle_space = game_state.board.space(4)
      first_player = game_state.players.first
      second_player = game_state.players.last

      expect(middle_space.token).to eq('X')
      expect(first_player.token).to eq('X')
      expect(second_player.token).to eq('O')
    end
  end

  describe '#game_state_to_board_structure' do
    it 'returns a board structure based on a game state object' do
      player_factory = TicTacToes::PlayerFactory.new('unused_io')
      first_player = player_factory.generate_human_player('X')
      second_player = player_factory.generate_computer_player('O', :hard)
      players = [first_player, second_player]
      board = TicTacToes::Board.new
      board.place(first_player, 4)

      game_state = TicTacToes::GameState.new(board, players, UI::NullHistory.new)
      board_structure = [nil, nil, nil, nil, "X", nil, nil, nil, nil]
      expect(UI::Adapter.game_state_to_board_structure(game_state)).to eq(board_structure)
    end
  end
end
