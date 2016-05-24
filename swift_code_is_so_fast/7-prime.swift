
// ===----------------------------------------------------------------===//
//            Project "Swift" by Paulin Laroche - Task 7
//          by Alexandro de Oliveira, for Holberton School.
// ===----------------------------------------------------------------===//

/**
 * @discussion: This function checks if a number is prime.
 * @params: Accepts an Integer as parameter.
 * @returns: returns a boolean value.
 */
func is_prime(number: Int) -> (Bool) {
    if number <= 1 {
        return false
    }
    if number <= 3 {
        return true
    }
    var i = 2
    while i * i <= number {
        if number % i == 0 {
            return false
        }
        i += 1
    }
    return true
}
