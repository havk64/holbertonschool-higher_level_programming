// ===---------------------------------------===//
// Project "Swift" by Paulin Laroche - Task 0
// by Alexandro de Oliveira, for Holberton School.
// ===---------------------------------------===//

/**
 * @discussion Function Reverse accepts reverses a string given as parameter.
 * @param Accepts a string as argument.
 * @return Returns the string given as argument reversed.
 */
func reverse(str: String) -> String {
    return String(str.characters.reverse())
}

let str = "Hello Holberton school!" // String to be reversed
let reversed = reverse(str)         // Reversing the string and assigning it to a new variable
print(reversed)                     // Printing that variable
