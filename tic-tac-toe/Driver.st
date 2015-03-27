Object subclass: Driver [
  | current waiting board state continue |
  
  "Initialization"
  Driver class >> new [
    | r |
    r := super new.
    r init.
    ^r
  ]
  
  init [
    board := Board new.
  ]

  "Getters/Setters (Instance Methods)"
  current [
    ^current
  ]

  current: aPlayer [
    current := aPlayer
  ]

  waiting [
    ^waiting
  ]

  waiting: aPlayer [
    waiting := aPlayer
  ]

  board [
    ^board
  ]

  board: aBoard [
    board := aBoard
  ]
  
  state [
    ^state
  ]

  state: aState [
    state := aState
  ]
  
  continue [
    ^continue
  ]
  
  continue: boolean [
    continue := boolean.
  ]

  "Main Driver"
  start [
    "Create new game state"
    state := State new.
    "Evaluate the game state with the current board"
    state checkState: board.
    self printBoard: board.
    "Check if game over"
    state over ifTrue: [
      "Print winner and scores"
      self end: state.
      "Prompt user for another game"
      continue := self continuePrompt.
      "Create new board if continue true"
      continue ifTrue: [
        board := Board new
      ].
    ]
    ifFalse: [
      current makeMove: board.
      self switchPlayers.
    ].
  ]
  
  "Instance Methods"
  end: state [
    state winner isNil ifTrue: [
      Transcript show: 'It''s a Cat''s Game!'.
    ]
    ifFalse: [
      (state winner = 'X') ifTrue: [
        Transcript show: 'You have won, Human!'.
        "Increment human player score"
        (current token = 'X') ifTrue: [
          current score: (current score + 1).
        ]
        ifFalse: [
          waiting score: (waiting score + 1).
        ]
      ]
      ifFalse: [
        Transcript show: 'The Computer has won!'.
        "Increment computer player score"
        (current token = 'O') ifTrue: [
          current score: (current score + 1).
        ]
        ifFalse: [
          waiting score: (waiting score + 1).
        ]
      ]
    ].
    Transcript cr.
    self printScore.
  ]
  
  continuePrompt [
    | answer |
    "Prompt user"
    Transcript cr.
    Transcript show: 'Would you like to continue (y/n)?: '.
    "Get answer from user"
    answer := (stdin nextLine at: 1) asString.
    "Compare answer with regex"
    answer ~ '^(?:y|Y)$' ifTrue: [
      ^true
    ]
    ifFalse: [
      ^false
    ].
  ]
  
  switchPlayers [
    | temp |
    "Switch players"
    temp := current.
    current := waiting.
    waiting := temp.
  ]
  
  printBoard: board [
    self printRowDivider: board.
    Transcript cr.
    1 to: board size do: [ :i |
      self printRow: board row: i.
      Transcript cr.
      self printRowDivider: board.
      Transcript cr.
    ].
    (state over = false) & (current token = 'O') ifTrue: [
      Transcript cr.
      Transcript show: 'Computer''s move:'.
      Transcript cr
    ].
    Transcript cr.
  ]

  printRow: board row: row [
    Transcript show: '|'.
    1 to: board size do: [ :column |
      Transcript show: (board x: row y: column) asString, '|'.
    ].
  ]

  printRowDivider: board [
    1 to: (board size * 2) + 1 do: [ :i |
      Transcript show: '-'.
    ].
  ]
  
  printScore [
    "Output player scores"
    Transcript cr.
    Transcript show: '-SCORES------'.
    Transcript cr.
    (current token = 'X') ifTrue: [
      Transcript show: 'Human    = '.
    ]
    ifFalse: [
      Transcript show: 'Computer = '.
    ].
    Transcript show: current score asString.
    Transcript cr.
    (waiting token = 'X') ifTrue: [
      Transcript show: 'Human    = '.
    ]
    ifFalse: [
      Transcript show: 'Computer = '.
    ].
    Transcript show: waiting score asString.
    Transcript cr.
  ]

]
