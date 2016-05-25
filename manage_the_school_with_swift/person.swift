// ===----------------------------------------------------------------===//
//   Project "Manage the school with Swift" by Paulin Laroche - Task 0
//          by Alexandro de Oliveira, for Holberton School.
// ===----------------------------------------------------------------===//

/**
 * @discussion Declaring the class Person.
 */
class Person {
  var first_name = "" // Public attributes.
  var last_name = ""  
  var age = 0
  init(first_name: String, last_name: String, age: Int) { // The initializer.
    self.first_name = first_name
    self.last_name = last_name
    self.age = age
  }
  func fullName() -> String { // A public method.
    return self.first_name + " " + self.last_name
  }
}
