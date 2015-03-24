Object subclass: Interface [
  | input output |

  Interface class >> in: input out: output [
    ^self new
      input: input;
      output: output;
      yourself
  ]

  "Getters/Setters"
  input: value [
    input := value
  ]
  input [
    ^input
  ]

  output: value [
    output := value
  ]

  output [
    ^output
  ]

  "Class Method(s)"
  getMove: prompt [
    | input |
    output show: prompt.
    ^input nextLine asInteger.
  ]

  printBoard: board [
    output cr.
    self printRowDivider.
    1 to: board size do: [
      self printRow board.
      output cr.
      self printRowDivider.
      output cr.
    ].
    output cr.
  ]

  printRow: board [
    output show: $|.
    1 to: board size do: [ :column |
      1 to: board size do: [ :row |
        output show: (board x: row y: column) asString, '|'.
      ].
    ].
  ]

  printRowDivider [
    1 to: 7 do: [
      output show: '-'.
    ].
  ]

  end: state [
    output cr.
    state winner isNil ifTrue: [
      output show: 'Draw!'
    ]
    ifFalse: [
      output show: 'Congratulations ', state winner, ', you won!'
    ].
    output cr.
  ]

]
