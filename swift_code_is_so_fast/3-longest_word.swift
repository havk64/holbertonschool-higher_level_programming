// ===----------------------------------------------------------------===//
//            Project "Swift" by Paulin Laroche - Task 3
//          by Alexandro de Oliveira, for Holberton School.
// ===----------------------------------------------------------------===//

/**
 * @discussion: This Function returns the first longest word in a sentence.
 * @params: Accepts a String as parameter.
 * @returns: returns the the most
 */
func longest_word(text: String) -> (String) {
  let splited = text.characters.split{$0 == " "}.map(String.init)
  var longest = ""
  for word in splited {
    longest = (word.characters.count > longest.characters.count) ? word : longest
  }
  return longest
}
