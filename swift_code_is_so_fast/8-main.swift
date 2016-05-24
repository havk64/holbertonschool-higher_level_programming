// ===----------------------------------------------------------------===//
//            Project "Swift" by Paulin Laroche - Task 8
//          by Alexandro de Oliveira, for Holberton School.
// ===----------------------------------------------------------------===//

/**
 * @discussion: It joins an array of strings.
 * @params: An array of strings.
 * @returns: returns just one string.
 */
let strings = ["We", "Heart", "Swift"]

let string = strings.reduce("", combine: {$0 + " " + $1})

print(string)
