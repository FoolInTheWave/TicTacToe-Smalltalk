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
