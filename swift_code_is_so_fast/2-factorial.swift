// ===----------------------------------------------------------------===//
//            Project "Swift" by Paulin Laroche - Task 2
//          by Alexandro de Oliveira, for Holberton School.
// ===----------------------------------------------------------------===//

/**
 * @discussion: This Function returns a factorial of a given number.
 * @params: Accepts an Integer as parameter.
 * @returns: returns the factorial of the given number.
 */
func factorial(N: Int) -> (Int) {
  if N <= 1 {
    return 1
  }
  return N * factorial(N - 1)
}
