// ===----------------------------------------------------------------===//
//      Project "Manage the school with Swift" by Paulin Laroche
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

/**
* @discussion Declaring the class Mentor.
*/
class Mentor: Person, Classify {
    let subject: Subject

    init(first_name: String, last_name: String, age: Int, subject: Subject = Subject.Math) {
        self.subject = subject
        super.init(first_name: first_name, last_name: last_name, age: age)
    }

    func stringSubject() -> String {
        switch (self.subject) {
            case .Math:
                return "Math"

            case .English:
                return "English"

            case .French:
                return "French"

            case .History:
                return "History"
        }
    }

    func isStudent() -> Bool { // Declaring isStudent() to meet protocol requirements.
        return false
    }
}

/**
* @discussion Declaring the class Student.
*/
class Student: Person, Classify {
    func isStudent() -> Bool { // Declaring isStudent to meet protocol requirements.
        return true
    }
}

/**
* @discussion Declaring the protocol Classify.
*/
protocol Classify {
    func isStudent() -> Bool
}

/**
* @discussion Declaring the enumerator Subject.
*/
enum Subject {
    case Math
    case English
    case French
    case History
}
