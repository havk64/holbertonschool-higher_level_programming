// ===----------------------------------------------------------------===//
//            Project "Swift" by Paulin Laroche - Task 2
//          by Alexandro de Oliveira, for Holberton School.
// ===----------------------------------------------------------------===//

/**
 * @discussion: This Function returns a factorial of a given number.
 * @params: Accepts an Integer as parameter.
 * @returns: returns the factorial of the given number.
 */
func longest_word(text: String) -> (String) {
  let splited = text.characters.split{$0 == " "}.map(String.init)
  var longest = ""
  for word in splited {
    longest = (word.characters.count > longest.characters.count) ? word : longest
  }
  return longest
}
