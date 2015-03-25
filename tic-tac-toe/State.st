Object subclass: State [
  | over winner |
  
  "Initialization"
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

  "Getters/Setters (Instance Methods)"
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

  "Instance Methods"
  checkState: board [
    1 to: board size do: [ :index |
      "Check if the entirety of the current row or column is marked by the player"
      (board row: index allEqualTo: board player) | (board column: index allEqualTo: board player) ifTrue: [
        winner := board player
      ]
      ifFalse: [
        "Check if the entirety of the current row or column is marked by the computer"
        (board row: index allEqualTo: board computer) | (board column: index allEqualTo: board computer) ifTrue: [
          winner := board computer
        ]
      ]
    ].

    "Check if the entirety of either diagonal is marked by the player"
    (board diagonal1allEqualTo: board player) | (board diagonal2allEqualTo: board player) ifTrue: [
      winner := board player
    ]
    ifFalse: [
      "Check if the entirety of either diagonal is marked by the computer"
      (board diagonal1allEqualTo: board computer) | (board diagonal2allEqualTo: board computer) ifTrue: [
        winner := board computer
      ]
    ].

    (board isFull) | (winner isNil = false) ifTrue:[
      over := true
    ]
  ]
  
  scoreFor: player [
    winner isNil ifTrue: [
      ^0
    ]
    ifFalse: [
      (player = winner) ifTrue: [
        ^1000
      ]
      ifFalse: [
        ^-1000
      ]
    ]
  ]

]
