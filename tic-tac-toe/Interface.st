Object subclass: Interface [
  | inStream outStream | 
  
  Interface class >> in: inStream out: outStream [
    ^self new
      inStream: inStream;
      outStream: outStream;
      yourself
  ]
  
  "Getters/Setters"
  inStream: value [ 
    inStream := value 
  ]
  inStream [ 
    ^inStream 
  ]
  
  outStream: value [ 
    outStream := value 
  ]
  
  outStream [ 
    ^outStream 
  ]
  
  "Class Method(s)"
  getMove: prompt [
    | input x y |
    outStream show: prompt.
    ^inStream nextLine asInteger.
  ]
  
  printBoard: board [
    outStream cr.
    self printRowDivider.
    1 to: board size do: [
      self printRow board.
      outStream cr.
      self printRowDivider.
      outStream cr.
    ].
    outStream cr.
  ]
  
  printRow: board [
    outStream show: $|.
    1 to: board size do: [ :column |
      1 to: board size do: [ :row |
        outStream show: (board x: row y: column) asString, '|'. 
      ].
    ].
  ]
  
  printRowDivider [
    1 to: 7 do: [
      outStream show: '-'.
    ].
  ]
  
  end: state [
    outStream cr.
    state winner isNil ifTrue: [
      outStream show: 'Draw!'
    ]
    ifFalse: [
      outStream show: 'Congratulations ', state winner, ', you won!'      
    ].
    outStream cr.
  ]

]
