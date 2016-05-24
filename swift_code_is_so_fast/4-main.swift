// ===----------------------------------------------------------------===//
//            Project "Swift" by Paulin Laroche - Task 4
//          by Alexandro de Oliveira, for Holberton School.
// ===----------------------------------------------------------------===//

/**
 * @discussion: This Function returns the maximum value of an array.
 * @params: Accepts a Integer as parameter.
 * @returns: returns the the highest value.
 */

var numbers = [4, 7, 1, 9, 6, 5, 6, 9]

let max = numbers.reduce(0, combine: { $0 > $1 ? $0 : $1 })

print(max)
