Object subclass: Player [
  | interface token |

  "Constructor"
  Player class >> token: token [
    ^self new
      token: token;
      yourself.
  ]

  "Getters/Setters"
  token [
    ^token
  ]

  token: value [
    token := value
  ]

  interface [
    ^interface
  ]

  interface: value [
    interface := value
  ]

  "Class Method(s)"
  prompt [
    ^'Please enter your move (1-9): '
  ]

  invalidPrompt [
    ^'Cell taken or invalid input. Please enter your move (1-9): '
  ]

  makeMove: board prompt: prompt [
    [board setCell: token index: (interface getMove: prompt)]
    on: Error
    do: [
      self makeMove: board prompt: (self invalidPrompt)
    ]
  ]

  makeMove: board [
    self makeMove: board prompt: (self prompt).
  ]

]
