// ===----------------------------------------------------------------===//
//            Project "Swift" by Paulin Laroche - Task 1
//            by Alexandro de Oliveira, for Holberton School.
// ===----------------------------------------------------------------===//

/**
 * @discussion: Function is_palindrome checks if a string is a palindrome.
 * @params: Accepts a String as parameter.
 * @returns: returns a boolean value if the string is a palindrome or not.
 */
func is_palindrome(s: String) -> Bool {
  return String(s.characters.reverse()) == s
}
