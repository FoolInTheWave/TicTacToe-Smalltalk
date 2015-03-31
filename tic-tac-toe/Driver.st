"**
  Author: Caleb Miller
  Date: 03-27-2015

  This is the class that drives the tic tac toe game. Methods for
  printing the board to output are defined here.
**"
Object subclass: Driver [
  | current waiting board state continue draw |

  "**
    Initialization
  **"
  Driver class >> new [
    | r |
    r := super new.
    r init.
    ^r
  ]

  init [
    board := Board new.
    draw := 0
  ]

  "**
    Getters/Setters
  **"
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
  
  draw [
    ^draw
  ]

  draw: int [
    draw := int.
  ]

  "**
    Author: Caleb Miller
    Date: 03-27-2015

    This method checks the current state of the game by passing the
    board object to a newly created state object. The state of the
    game is returned. If the state is over then the user is prompted
    for another game.
  **"
  start [
    "Create new game state"
    state := State new.
    "Evaluate the game state with the current board"
    state checkState: board.
    self printBoard: board.
    "Check if game over"
    state over ifTrue: [
      "Print winner and scores"
      self end.
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

  "**
    Author: Caleb Miller
    Date: 03-27-2015

    This method prints the outcome of the game along with the player
    scores.
  **"
  end [
    state winner isNil ifTrue: [
      Transcript show: 'It''s a Cat''s Game!'.
      draw := draw + 1.
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

  "**
    Author: Caleb Miller
    Date: 03-27-2015

    This method writes a prompt to output using the Transcript
    object asking whether or not the player wishes to continue.
    A regex is used to compare the user response to valid input.

    Output:
      A boolean value indicating if the user wishes to continue with
      another game.
  **"
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

  "**
    Author: Caleb Miller
    Date: 03-27-2015

    This method switches the object references between the current
    and waiting instance variables.
  **"
  switchPlayers [
    | temp |
    "Switch players"
    temp := current.
    current := waiting.
    waiting := temp.
  ]

  "**
    Author: Caleb Miller
    Date: 03-27-2015

    This method print the tic tac toe board to output using the
    Transcript object.

    Input:
      board - A Board object.
  **"
  printBoard: board [
    self printRowDivider: board.
    Transcript cr.
    1 to: board size do: [ :index |
      self printRow: board row: index.
      Transcript cr.
      self printRowDivider: board.
      Transcript cr.
    ].
    (state over = false) & (current token = 'O') ifTrue: [
      Transcript cr.
      Transcript show: 'Computer''s move:'.
    ].
    Transcript cr.
  ]

  "**
    Author: Caleb Miller
    Date: 03-27-2015

    This method prints a row of the board to output.

    Input:
      board - A Board object.
      index - A numeric value representing the row to print.
  **"
  printRow: board row: index [
    | currCell rowEnd |
    currCell := index * board size - (board size - 1).
    rowEnd := currCell + board size - 1.
    Transcript show: '|'.
    [currCell <= rowEnd] whileTrue: [
      Transcript show: (board cells at: currCell) asString, '|'.
      currCell := currCell + 1.
    ].
  ]

  "**
    Author: Caleb Miller
    Date: 03-27-2015

    This method prints a board row divider to output.

    Input:
      board - A Board object.
  **"
  printRowDivider: board [
    1 to: (board size * 2) + 1 do: [ :i |
      Transcript show: '-'.
    ].
  ]

  "**
    Author: Caleb Miller
    Date: 03-27-2015

    This method checks the current state of the game by passing the
    board object to a newly created state object. The state of the
    game is returned. If the state is over then the user is prompted
    for another game.
  **"
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
    Transcript show: 'Draw     = '.
    Transcript show: draw asString.
    Transcript cr.
  ]

]
