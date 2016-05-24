// ===----------------------------------------------------------------===//
//            Project "Swift" by Paulin Laroche - Task 5
//          by Alexandro de Oliveira, for Holberton School.
// ===----------------------------------------------------------------===//

/**
 * @discussion: This Function makes use of "memoization" in order to optimize func calls.
 * @params: Accepts a Hashable function as parameter.
 * @returns: returns a function call.
 */
func memoize<T: Hashable, U>(body: ((T)->U, T) -> U) -> (T)->U {
    var memo = [T: U]()                   // memorizing the function.
    var result: ((T)->U)!                 // Formatting the output.
    result = { x in                       // Using a closure to optimize the function call.
        if let q = memo[x] { return q }
        let r = body(result, x)
        memo[x] = r
        return r
    }
    return result
}

/**
 * @discussion: Fibonacci uses memoize function to improve the performance of recursiveness.
 * @params: Accepts a number as parameter.
 * @returns: returns the respective fibonacci number.
 */
let fibonacci = memoize { fib, x in x < 2 ? x : fib(x - 1) + fib(x - 2) }
