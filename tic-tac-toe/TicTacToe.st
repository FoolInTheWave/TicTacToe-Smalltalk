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
    | state answer newBoard |
    "Assume player wants to continue with another game"
    answer := 'Y'.
    "Do not create a new board right away"
    newBoard := false.
    [
      self printBoard: board.
      "Create new game state"
      state := State new.
      "Evaluate the game state with the current board"
      state checkState: board.
      state over ifTrue: [
        self end: state.
        "Prompt user for another game"
        answer := (self continue at: 1) asString.
        "Assume new game"
        newBoard := true.
      ]
      ifFalse: [
        current makeMove: board.
        self switchPlayers.
      ].
      
      newBoard = true ifTrue: [
        "Create new board for new game"
        board := Board new.
        newBoard := false.
      ].

      answer ~ '^(?:y|Y)$'
    ] whileTrue: [ ]
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

Object subclass: Board [
  | cells size player computer empty |
  
  "Initialization"
  Board class >> new [
    | r |
    r := super new.
    r init.
    ^r
  ]
  
  init [
    size := 3.
    player := 'X'.
    computer := 'O'.
    empty := ' '.
    "Initialize cells to be empty"
    cells := OrderedCollection new.
    1 to: size * size do: [ :i |
      cells add: empty
    ].
  ]

  "Getters/Setters (Instance Methods)"
  cells [
    ^cells
  ]

  cells: list [
    cells := list
  ]

  size [
    ^size
  ]

  size: number [
    size := number
  ]

  player [
    ^player
  ]

  player: token [
    player := token
  ]

  computer [
    ^computer
  ]

  computer: token [
    computer := token
  ]

  empty [
    ^empty
  ]

  empty: token [
    empty := token
  ]

  "Instance Methods"
  isFull [
    "Check if all cells in board are marked"
    ^cells conform: [ :cell | 
      cell ~= empty 
    ]
  ]

  otherPlayer: player [
    "Return the opposite player"
    (player = player) ifTrue: [
      ^computer
    ] ifFalse: [
      ^player
    ]
  ]

  row: row allEqualTo: token [
    | column equal |
    "Check if entire row is marked by specified player"
    equal := true.
    column := 1.
    "While equal is true and within board size"
    [equal & (column <= size)] whileTrue: [
      "Check if cell contents are equal to passed token"
      equal := token = (self x: column y: row).
      "Increment to next column in row"
      column := column + 1
    ].
    ^equal
  ]

  column: column allEqualTo: token [
    | row equal |
    "Check if entire column is marked by specified player"
    equal := true.
    row := 1.
    "While equal is true and within board size"
    [equal & (row <= size)] whileTrue: [
      "Check if cell contents are equal to passed token"
      equal := token = (self x: column y: row).
      "Increment to next row in column"
      row := row + 1
    ].
    ^equal
  ]

  diagonal1allEqualTo: token [
    | i equal |
    "Check if first diagonal is marked by specified player"
    equal := true.
    i := 1.
    "While equal is true and within board size"
    [equal & (i <= size)] whileTrue: [
      "Check if cell contents are equal to passed token"
      equal := token = (self x: i y: i).
      "Increment to next cell in diagonal"
      i := i + 1.
    ].
    ^equal
  ]

  diagonal2allEqualTo: token [
    | i equal |
    "Check if second diagonal is marked by specified player"
    equal := true.
    i := 1.
    "While equal is true and within board size"
    [equal & (i <= size)] whileTrue: [
      "Check if cell contents are equal to passed token"
      equal := token = (self x: i  y: (size - i + 1)).
      "Increment to next cell in diagonal"
      i := i + 1.
    ].
    ^equal
  ]

  convertIndex: x y: y [
    "Convert matrix index to one-dimensional index"
    ^(x - 1 * size + y)
  ]

  x: x y: y [
    "Return cell contents at specified index"
    ^cells at: (self convertIndex: x y: y).
  ]

  setCell: token index: index [
    "Cell must be empty before it can be marked"
    (cells at: index) ~= empty ifTrue: [
      self error: 'Coordinate taken.'
    ].
    cells at: index put: token.
  ]

  getEmptyCells [
    | empties |
    empties := OrderedCollection new.
    "Loop through current board cells"
    1 to: (cells size) do: [ :i |
      "Check if cell is empty"
      (cells at: i) = empty ifTrue: [
        "Add index of empty cell to empty cell collection"
        empties add: i
      ]
    ].
    "Return empty cell collection"
    ^empties
  ]

]

Object subclass: State [
  | over winner |
  
  "Initialization"
  State class >> new [
    | r |
    r := super new.
    r init.
    ^r
  ]
  
  init [
    "Assume the game state is valid"
    over := false
  ]

  "Getters/Setters (Instance Methods)"
  winner [
    ^winner
  ]
  
  winner: player [
    winner := player
  ]
  
  over [
    ^over
  ]

  over: value [
    over := value
  ]

  "Instance Methods"
  checkState: board [
    1 to: board size do: [ :index |
      "Check if the entirety of the current row or column is marked by the player"
      (board row: index allEqualTo: board player) | (board column: index allEqualTo: board player) ifTrue: [
        winner := board player
      ]
      ifFalse: [
        "Check if the entirety of the current row or column is marked by the computer"
        (board row: index allEqualTo: board computer) | (board column: index allEqualTo: board computer) ifTrue: [
          winner := board computer
        ]
      ]
    ].

    "Check if the entirety of either diagonal is marked by the player"
    (board diagonal1allEqualTo: board player) | (board diagonal2allEqualTo: board player) ifTrue: [
      winner := board player
    ]
    ifFalse: [
      "Check if the entirety of either diagonal is marked by the computer"
      (board diagonal1allEqualTo: board computer) | (board diagonal2allEqualTo: board computer) ifTrue: [
        winner := board computer
      ]
    ].

    (board isFull) | (winner isNil = false) ifTrue:[
      over := true
    ]
  ]
  
  scoreFor: player [
    winner isNil ifTrue: [
      ^0
    ]
    ifFalse: [
      (player = winner) ifTrue: [
        ^1000
      ]
      ifFalse: [
        ^-1000
      ]
    ]
  ]

]

Object subclass: Player [
  | token score |

  "Initialization"
  Player class >> new [
    | r |
    r := super new.
    r init.
    ^r
  ]
  
  init [
    token := 'X'.
    score := 0
  ]
  
  "Getters/Setters (Instance Methods)"
  token [
    ^token
  ]

  token: char [
    token := char
  ]
  
  score [
    ^score
  ]

  score: number [
    score := number
  ]

  "Instance Methods"
  prompt [
    ^'Please enter your move (1-9): '
  ]

  invalidPrompt [
    ^'Cell taken or invalid input. Please enter your move (1-9): '
  ]

  makeMove: board prompt: prompt [
    [board setCell: token index: (self getMove: prompt)]
    on: Error
    do: [
      self makeMove: board prompt: (self invalidPrompt)
    ]
  ]

  makeMove: board [
    self makeMove: board prompt: (self prompt).
  ]
  
  getMove: prompt [
    | input |
    "Prompt user"
    Transcript show: prompt.
    "Get cell number from user"
    ^stdin nextLine asInteger.
  ]

]

Object subclass: Computer [
  | token score |

  "Initialization"
  Computer class >> new [
    | r |
    r := super new.
    r init.
    ^r
  ]
  
  init [
    token := 'O'.
    score := 0
  ]
  
  "Getters/Setters (Instance Methods)"
  token [
    ^token
  ]

  token: char [
    token := char
  ]
  
  score [
    ^score
  ]

  score: number [
    score := number
  ]

  "Instance Methods"
  makeMove: board [
    | generator cell index |
    "Initialize random number generator"
    generator := Random new.
    "Generate random number between 1 and emptyCell collection size"
    cell := generator between: 1 and: board getEmptyCells size.
    "Get coordinate of empty cell from emptyCells"
    index := board getEmptyCells at: cell.
    "Place token in empty cell on board"
    board setCell: token index: index.
  ]

]

"ENTRY POINT"
driver := Driver new.
driver start.
