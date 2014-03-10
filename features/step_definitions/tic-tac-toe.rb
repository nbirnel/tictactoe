class TicTacToe
  SYMBOLS = [:X, :O]
  PLAYERS = [:player, :computer]
  attr_reader :player
  attr_accessor :player_symbol, :computer_symbol, :players, :whose_turn, :board

  def initialize starts=PLAYERS[dien], s=SYMBOLS[dien]
    @name    = {:player => 'Player', :computer => 'Computer'} 
    @whose_turn = PLAYERS.index starts
    @whose_symb = SYMBOLS.index s
    @symbol  = {
      #PLAYERS[@whose_turn]   => s,
      :player => s,
      :computer => SYMBOLS[(SYMBOLS.index s)^1]
    }
    @board = {
      :A1 => ' ', :A2 => ' ', :A3 => ' ',
      :B1 => ' ', :B2 => ' ', :B3 => ' ',
      :C1 => ' ', :C2 => ' ', :C3 => ' '
    }
  end

  def player= name
    @player = @name[:player] = name
  end

  def open_spots
    board.select{|spot, v| v == ' '}.keys
  end

  #FIXME refactor these 2
  def player_symbol
    @symbol[:player]
  end

  def computer_symbol
    @symbol[:computer]
  end

  def welcome_player
    "Welcome #{@player}"
  end

  def current_player
    @name[PLAYERS[@whose_turn]]
  end

  def indicate_player_turn
    puts "#{@player}'s Move:"
  end

  def get_player_move
    move = gets.chomp
  end

  def player_move
    pos = get_player_move.to_sym
    until self.open_spots.include? pos
      puts "#{pos} is taken, yo. Try again."
      pos = get_player_move.to_sym
    end
    @board[pos] = @symbol[:player]
    pos
  end

  def computer_move
    pos = open_spots[dien open_spots.length - 1]
    @board[pos] = @symbol[:computer]
    pos
  end

  def current_state
    @board.map{|pos, state| state.to_s}
  end

  def over?
    false
  end

  def spots_open?
    open_spots.length > 0
  end

  def determine_winner
    a = current_state

    #FIXME refactor, duh
    [0, 3, 6].each do |row|
      if a[row] = a[row+1] = a[row+2]
        winner = a[row]
      end
    end

    [0, 1, 2].each do |col|
      if a[col] = a[col+3] = a[col+6]
        winner = a[col]
      end
    end

    if (a[0] = a[4] = a[8]) || (a[6] = a[4] = a[2])
      winner = a[4]
    end

    @winning_token = winner == ' ' ? false : winner
  end

  def player_won?
    puts @winning_token
    @winning_token == player_symbol
  end

  private

  def toggle_current_player
    self.whose_turn = self.whose_turn^1
  end

  def dien n=1
    rand(0..n)
  end

end
