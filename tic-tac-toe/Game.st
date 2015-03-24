Object subclass: Driver [
  | interface currentPlayer waitingPlayer board |

  "Constructor"
  Driver class >> [
    | player1 |
    player1 := Human marker: #X.
    ^self new
      interface: (Interface in: stdin out: Transcript);
      player1 setInterface: interface.
      currentPlayer: player1;
      waitingPlayer: (Computer marker: #O);
      board: (Board new: 3 player1: #X player2: #O empty: #' ');
      yourself
  ]
  
  "Getters/Setters"
  interface [ 
    ^interface 
  ]
  
  interface: value [ 
    interface := value 
  ]
  
  currentPlayer [ 
    ^currentPlayer 
  ]
  
  currentPlayer: value [ 
    currentPlayer := value 
  ]
  
  waitingPlayer [ 
    ^waitingPlayer 
  ]
  waitingPlayer: value [ 
    waitingPlayer := value 
  ]
  
  board [ ^board ]
  board: value [ board := value ]
  
  "Main Driver"
  main [
    | state playerTmp |
    interface printBoard: board.
    state := GameState board: board.
    state over ifTrue: [
      interface gameOver: state.
    ]
    ifFalse: [
      currentPlayer makeMove: board.
      playerTmp := currentPlayer.
      currentPlayer := waitingPlayer.
      waitingPlayer := playerTmp.
      self main
    ]
  ]

]
