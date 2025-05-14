## May 14, 2025 - 2:45 pm

### Project Overview

The goal of this project was to implement a prefix-notation calculator in Racket that supports both interactive and batch modes. The calculator evaluates expressions written in prefix form (e.g., `+ 2 3`), tracks a history of successful results, and allows referencing previous results using the `$n` syntax. Error handling was a key requirement, with all invalid expressions outputting a standard error message.

### Key Features

- Interactive mode for user prompts, and batch mode using `-b` or `--batch` flags
- Binary operations: `+`, `*`, `/`
- Unary operation: `-`
- Support for referencing past results using `$1`, `$2`, etc.
- Error handling for invalid expressions and division by zero
- History management using a list that tracks results in the order added

## May 14, 2025 - 4:20 pm

### Approach

- Started by parsing command-line arguments to determine program mode
- Tokenized user input using `regexp-split` to cleanly handle spacing issues
- Created a recursive parser (`eval-expr`) that evaluates tokens in prefix order
- Maintained history using a simple cons-based list, reversed when accessing `$n`
- Ensured proper float formatting using `real->double-flonum` when displaying results

### Common Issues Faced

1. **Whitespace sensitivity**: Racket's handling of character lists was causing issues when parsing input. Switched to string tokenization to cleanly separate tokens based on whitespace.
2. **Symbol misinterpretation**: Initially had trouble detecting the `+` symbol due to attempting to parse input at the character level. Token-based parsing fixed this.
3. **Drop function error**: Accidentally passed a list instead of an index to `drop`, which resulted in a contract violation. Fixed by ensuring correct argument order.
4. **History references**: Initially mismanaged `$n` values by not reversing the history before lookup. Corrected using `(list-ref (reverse history) (- n 1))`.

## May 14, 2025 - 5:10 pm

### Reflection

I underestimated how different functional programming is compared to imperative styles. The biggest challenge was unlearning habits from other languages and working entirely with recursion and immutable state. Tokenizing the input string early on simplified the logic a lot, especially when debugging syntax issues.

I was also reminded of how powerful but low-level error messages in Racket can be — some issues like incorrect `drop` usage took longer to fix simply because the feedback was cryptic at first. Once the calculator started printing history results properly and accepting `$n` references, it felt incredibly satisfying to see it all come together.

In hindsight, spending more time diagramming the recursive flow before coding might've helped me avoid some of the messier bugs, but overall this was a solid learning experience.
