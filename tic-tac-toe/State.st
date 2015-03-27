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

  over: value [
    over := value
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
