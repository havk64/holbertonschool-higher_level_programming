// ===----------------------------------------------------------------===//
//            Project "Swift" by Paulin Laroche - Task 6
//          by Alexandro de Oliveira, for Holberton School.
// ===----------------------------------------------------------------===//

/**
 * @discussion: This Function is used in order to reverse an array.
 * @params: Accepts an array as parameter.
 * @returns: returns a reversed array.
 */
 func reverse_array(a: [Int]) -> ([Int]) {
   var array = [Int]()
   for i in a.reverse() {
     array.append(i)
   }
   return array
 }
