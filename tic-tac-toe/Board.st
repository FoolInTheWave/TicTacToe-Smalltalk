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
