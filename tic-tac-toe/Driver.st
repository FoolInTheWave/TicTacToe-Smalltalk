Object subclass: Driver [
  | current waiting board |
  
  "Initialization"
  Driver class >> new [
    | r |
    r := super new.
    r init.
    ^r
  ]
  
  init [
    current := Player new.
    waiting := Computer new.
    board := Board new.
  ]

  "Getters/Setters (Instance Methods)"
  current [
    ^current
  ]

  current: value [
    current := value
  ]

  waiting [
    ^waiting
  ]

  waiting: value [
    waiting := value
  ]

  board [
    ^board
  ]

  board: value [
    board := value
  ]

  "Main Driver"
  start [
    | state answer |
    self printBoard: board.
    "Create new game state"
    state := State new.
    "Evaluate the game state with the current board"
    state checkState: board.
    state over ifTrue: [
      self end: state.
      [
        answer := (self continue at: 1) asString.
        answer ~ '^(?:y|n|Y|N)$'
      ] whileFalse: [ ].
      
      answer ~ '^(?:y|Y)$' ifTrue: [
        board := Board new.
        self start
      ].
    ]
    ifFalse: [
      current makeMove: board.
      self switchPlayers.
      "Start next game state"
      self start
    ]
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
    
    "Output player scores"
    Transcript cr.
    Transcript show: 'SCORES:'.
    Transcript cr.
    (current token = 'X') ifTrue: [
      Transcript show: 'Human: '.
    ]
    ifFalse: [
      Transcript show: 'Computer: '.
    ].
    Transcript show: current score asString.
    Transcript cr.
    (waiting token = 'X') ifTrue: [
      Transcript show: 'Human: '.
    ]
    ifFalse: [
      Transcript show: 'Computer: '.
    ].
    Transcript show: waiting score asString.
    Transcript cr.
  ]
  
  continue [
    "Prompt user"
    Transcript cr.
    Transcript show: 'Would you like to continue (y/n)?: '.
    "Get answer from user"
    ^stdin nextLine.
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

]
