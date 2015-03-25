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
