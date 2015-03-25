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
