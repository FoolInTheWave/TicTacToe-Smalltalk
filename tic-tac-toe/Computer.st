Player subclass: Computer [
  | token |

  "Constructor"
  Computer class >> token: token [
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

  "Class Method(s)"
  makeMove: board [
    | found generator index |
    found := false.
    [found = false] whileTrue: [
      generator := Random new.
      index := generator between: 1 and: (board size * board size).
      board emptyCells do: [ :cell |
        [index = cell] ifTrue: [
          found := true.
        ]
      ]
    ].

    board setCell: token index: index.
  ]

]
