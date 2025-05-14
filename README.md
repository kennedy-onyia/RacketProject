# Racket Prefix Expression Calculator

In this project I will create a prefix-notation expression calculator. The calculator will prompt the user for an expression in prefix notation and calculate the result of the inputted expression. A history will be kept so that previous results can be used in expressions.<break>

## Features

- Prefix notation evaluation (e.g. + 2 3 → 5.0)
- Unary negation (e.g. - 4 → -4.0)
- Binary operations: +, \*, /
- History tracking using $n (e.g. $1 refers to result with ID 1)
- Error handling with "Error: Invalid Expression"
- Batch mode for clean automated evaluation

## How to Run Program

- Install Racket on device from the [Racket website](https://racket-lang.org/)<break>

- Run in interactive mode (default):  
   `racket code.rkt`  
  Note: code.rkt is simply the name of the racket file <break>

- Alternatively, Run in batch mode (no prompts):  
   `racket project1.rkt -b` or
  `racket project1.rkt --batch`  
  Note: This mode will only output results and errors
