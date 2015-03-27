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
