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
