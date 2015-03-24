Object subclass: Driver [
  | interface currentPlayer waitingPlayer board |

  "Constructor"
  Driver class >> [
    | player1 |
    player1 := Player token: #X.
    ^self new
      interface: (Interface in: stdin out: Transcript);
      player1 interface: interface.
      currentPlayer: player1;
      waitingPlayer: (Computer token: #O);
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

  board [
    ^board
  ]

  board: value [
    board := value
  ]

  "Main Driver"
  main [
    | state playerTmp |
    interface printBoard: board.
    state := State board: board.
    state over ifTrue: [
      interface end: state.
    ]
    ifFalse: [
      currentPlayer makeMove: board.
      "Switch players"
      playerTmp := currentPlayer.
      currentPlayer := waitingPlayer.
      waitingPlayer := playerTmp.
      "Begin next game state"
      self main
    ]
  ]

]
