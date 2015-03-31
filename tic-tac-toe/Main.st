"**
  Author: Caleb Miller
  Date: 03-27-2015
  Course: CS 451 15/WI Programming Language Concepts

  Purpose:
    This program is a command line based tic tac toe game between a
    human player and a computer player. The program prompts the
    human player for a move and then the computer makes a move.
    After a game ends the player is prompted to play again, and
    scores are stored throughout the games. To run this program you
    must have GNU Smalltalk installed. Execute the program with this
    command:

    gst -g Main.st

    If you omit the -g flag garbage collection messages will appear
    on the command line along with program output.
**"

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

"**
  Author: Caleb Miller
  Date: 03-27-2015

  This class represents a tic tac toe board. An OrderedCollection
  object stores board data, but in a single dimensioned collection.
  The board can be thought of as follows:

  -------
  |1|2|3|
  -------
  |4|5|6|
  -------
  |7|8|9|
  -------
**"
Object subclass: Board [
  | cells size player computer empty |

  "**
    Initialization
  **"
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

  "**
    Getters/Setters
  **"
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

  "**
    Author: Caleb Miller
    Date: 03-27-2015

    This method checks if the row indicated by the passed index
    is marked completely by a specified token.

    Input:
      index - A numeric value indicating the row to check.
      token - The player mark to check against.

    Output:
      A boolean value indicating if the entire row is marked by
      the specified token.
  **"
  row: index isEqualTo: token [
    | currCell rowEnd equal |
    equal := true.
    currCell := index * size - (size - 1).
    rowEnd := currCell + size - 1.
    "While equal is true and within row size"
    [equal & (currCell <= rowEnd)] whileTrue: [
      "Check if cell contents are equal to passed token"
      equal := token = (cells at: currCell).
      "Increment to next column in row"
      currCell := currCell + 1.
    ].
    ^equal
  ]

  "**
    Author: Caleb Miller
    Date: 03-27-2015

    This method checks if the column indicated by the passed index
    is marked completely by a specified token.

    Input:
      index - A numeric value indicating the column to check.
      token - The player mark to check against.

    Output:
      A boolean value indicating if the entire column is marked by
      the specified token.
  **"
  column: index isEqualTo: token [
    | currCell colEnd equal |
    equal := true.
    currCell := index.
    colEnd := index + (size * (size - 1)).
    "While equal is true and within board size"
    [equal & (currCell <= colEnd)] whileTrue: [
      "Check if cell contents are equal to passed token"
      equal := token = (cells at: currCell).
      "Increment to next row in column"
      currCell := currCell + size.
    ].
    ^equal
  ]

  "**
    Author: Caleb Miller
    Date: 03-27-2015

    This method checks if the first diagonal on the board is marked
    completely by a specified token.

    Input:
      token - The player mark to check against.

    Output:
      A boolean value indicating if the entire diagonal is marked by
      the specified token.
  **"
  firstDiagonalEqualTo: token [
    | currCell equal |
    equal := true.
    currCell := 1.
    "While equal is true and within board size"
    [equal & (currCell <= (size * size))] whileTrue: [
      "Check if cell contents are equal to passed token"
      equal := token = (cells at: currCell).
      "Increment to next cell in diagonal"
      currCell := currCell + size + 1.
    ].
    ^equal
  ]

  "**
    Author: Caleb Miller
    Date: 03-27-2015

    This method checks if the second diagonal on the board is marked
    completely by a specified token.

    Input:
      token - The player mark to check against.

    Output:
      A boolean value indicating if the entire diagonal is marked by
      the specified token.
  **"
  secondDiagonalEqualTo: token [
    | currCell equal |
    "Check if second diagonal is marked by specified player"
    equal := true.
    currCell := size.
    "While equal is true and within board size"
    [equal & (currCell <= (size * size - 2))] whileTrue: [
      "Check if cell contents are equal to passed token"
      equal := token = (cells at: currCell).
      "Increment to next cell in diagonal"
      currCell := currCell + size - 1.
    ].
    ^equal
  ]

  "**
    Author: Caleb Miller
    Date: 03-27-2015

    This method sets the cell value to the player token. The
    collection representing the board behind the scenes stores the
    player token.

    Input:
      token - The token to mark the cell with.
      index - The cell to mark.
  **"
  setCell: token index: index [
    "Cell must be empty before it can be marked"
    (cells at: index) ~= empty ifTrue: [
      self error: 'Coordinate taken.'
    ].
    cells at: index put: token.
  ]

  "**
    Author: Caleb Miller
    Date: 03-27-2015

    This method checks if all of the cells in the board are marked.

    Output:
      A boolean value indicating if all of the cells in the board
      have been marked.
  **"
  isFull [
    ^cells conform: [ :cell |
      cell ~= empty
    ]
  ]

  "**
    Author: Caleb Miller
    Date: 03-27-2015

    This method returns all empty cells in the board as a collection,
    with each value in the collection representing the index of the
    empty cell on the board.

    Output:
      An OrderedCollection containing the indexes of all empty cells
      on the board.
  **"
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

"**
  Author: Caleb Miller
  Date: 03-27-2015

  This is the class that checks the board to return the current game
  state.
**"
Object subclass: State [
  | over winner |

  "**
    Initialization
  **"
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

  "**
    Getters/Setters
  **"
  winner [
    ^winner
  ]

  winner: player [
    winner := player
  ]

  over [
    ^over
  ]

  over: boolean [
    over := boolean
  ]

  "**
    Author: Caleb Miller
    Date: 03-27-2015

    This method checks if each row, column, or diagonal has been
    completely marked by a player. The outcome of this check alters
    the game state.

    Input:
      board - A Board object to check.
  **"
  checkState: board [
    1 to: board size do: [ :index |
      "Check if the current row is completely marked by the human"
      (board row: index isEqualTo: board player) |
      (board column: index isEqualTo: board player) ifTrue: [
        winner := board player
      ]
      ifFalse: [
        "Check if the current column is completely marked by the computer"
        (board row: index isEqualTo: board computer) |
        (board column: index isEqualTo: board computer) ifTrue: [
          winner := board computer
        ]
      ]
    ].

    "Check if either diagonal is completely marked by the human"
    (board firstDiagonalEqualTo: board player) |
    (board secondDiagonalEqualTo: board player) ifTrue: [
      winner := board player
    ]
    ifFalse: [
      "Check if either diagonal is completely marked by the computer"
      (board firstDiagonalEqualTo: board computer) |
      (board secondDiagonalEqualTo: board computer) ifTrue: [
        winner := board computer
      ]
    ].

    (board isFull) | (winner isNil = false) ifTrue:[
      over := true
    ]
  ]

]

"**
  Author: Caleb Miller
  Date: 03-27-2015

  This is the class that represents a human player.
**"
Object subclass: Player [
  | token score |

  "**
    Initialization
  **"
  Player class >> new [
    | r |
    r := super new.
    r init.
    ^r
  ]

  init [
    token := 'X'.
    score := 0.
  ]

  "**
    Getters/Setters
  **"
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

  "**
    Author: Caleb Miller
    Date: 03-27-2015

    This method marks a cell specified by the player. Error handling
    is defined for invalid input.

    Input:
      board - A Board object.
  **"
  makeMove: board [
    [board setCell: token index: (self getMove)]
    on: Error
    do: [
      Transcript show: 'Cell taken or invalid input.'.
      Transcript cr.
      self makeMove: board
    ]
  ]

  "**
    Author: Caleb Miller
    Date: 03-27-2015

    This method gets the cell to mark by reading player input from
    stdin.

    Output:
      An integer is returned containing the player's desired move.
  **"
  getMove [
    | input |
    "Prompt user"
    Transcript show: 'Please enter your move (1-9): '.
    "Get cell number from user"
    ^stdin nextLine asInteger.
  ]

]

"**
  Author: Caleb Miller
  Date: 03-27-2015

  This is the class that represents a computer player.
**"
Object subclass: Computer [
  | token score |

  "**
    Initialization
  **"
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

  "**
    Getters/Setters
  **"
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

  "**
    Author: Caleb Miller
    Date: 03-27-2015

    This method has the computer marking a random empty cell on the
    board.
  **"
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

"**
  ENTRY POINT
**"
driver := Driver new.
firstPlayer := Player new.
secondPlayer := Computer new.
tempPlayer := Object new.

"Set game players"
driver current: firstPlayer.
driver waiting: secondPlayer.

"Assume player wants to continue with another game"
driver continue: true.
"Pseudo do-while loop"
[
  driver start.
  (driver state over) & (driver continue) ifTrue: [
    "Switch starting player"
    tempPlayer := firstPlayer.
    firstPlayer := secondPlayer.
    secondPlayer := tempPlayer.
    driver current: firstPlayer.
    driver waiting: secondPlayer
  ].
  "Do-while conditional statement"
  driver continue
] whileTrue: [ ]
