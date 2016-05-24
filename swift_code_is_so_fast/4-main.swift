// ===----------------------------------------------------------------===//
//            Project "Swift" by Paulin Laroche - Task 4
//          by Alexandro de Oliveira, for Holberton School.
// ===----------------------------------------------------------------===//

/**
 * @discussion: The closure returns the maximum value of an array.
 * @params: Accepts an array as parameter.
 * @returns: returns the highest value.
 */

var numbers = [4, 7, 1, 9, 6, 5, 6, 9]

let max = numbers.reduce(0, combine: { $0 > $1 ? $0 : $1 })

print(max)
