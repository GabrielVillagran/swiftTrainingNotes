import Foundation

/*
Closure: A closure is a self-contained block of code that captures and stores references to variables from its surrounding scope, Closures are useful for callbacks, API responses, and asynchronous operations.

Non-Escaping Closures** (Default in Swift):
   - The closure **only exists inside the function's scope**.
   - Once the function finishes execution, the closure is **deallocated**.
   - Used for **synchronous** operations.

 Escaping Closures** (`@escaping`):
   - The closure **outlives the function’s scope**.
   - Used in **asynchronous** operations like API calls or delayed execution.
   - The closure remains in memory until it’s executed.

 When choose Escaping or Non-Escaping: One thing we need to consider is if we are using any kind of operation that takes any amount of time is prefer to use Escaping, but if it is something that is not blocking we can go with non-escaping

 Race Condition: Happens when the order of events\\\\\\\\\\\\\\\\\\\yo  affects the correctnessof a piece of code

 Data Races: A data reace happens when one thread have access to a mutable object while another thread is writing on it, a race condition can happen without a data race and viceversa

*/

class TestClosure {

    // MARK: - Non-Escaping Closure Example
    func performAddition() {
        print("Step 1: Starting Addition")
        add(7, andNumber2: 2) { result in
            print("Step 3: Result of addition is \(result)")
        }
        print("Final Step: Addition Completed")
    }

    func add(_ num1: Int, andNumber2 num2: Int, completionHandler: (_ result: Int) -> Void) {
        print("Step 2: Calculating Sum")
        let sum = num1 + num2
        completionHandler(sum)  // Executes immediately
    }

    // MARK: - Escaping Closure Example
    func performSubtraction() {
        print("Step 1: Starting Subtraction")
        sub(7, andNumber2: 2) { result in
            print("Step 4: Result of subtraction is \(result)")
        }
        print("Final Step: Subtraction Requested (Waiting 3 sec...)")
    }

    func sub(_ num1: Int, andNumber2 num2: Int, completionHandler: @escaping (_ result: Int) -> Void) {
        print("Step 2: Preparing to Subtract")
        let result = num1 - num2

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            print("Step 3: Performing Subtraction")
            completionHandler(result)
        }
    }
}

// Running tests
let testClosure = TestClosure()
testClosure.performAddition()
testClosure.performSubtraction()

//----------------------------Protocols and Delegates-----------------------------------

/*
                                    Protocol Example
 Protocols: It's a design pattern and i like to explained that they are like a contract or blueprint of the methods or properties that a class, struct or enums can implement.
*/
protocol Vehicle {
    var numberOfWheels: Int { get }
    func start()
    func stop()
}

class Car: Vehicle {
    var numberOfWheels: Int =  4

    func start() {
        print("Car started")
    }
    func stop() {
        print("Car stopped")
    }
}
/*                                  Delegates Example
 Delegates: The delegates is also a design pattern that help us to develop applications, with the use of delegates we can asign one task or responsability from one object to be implemented in another object.
*/

protocol SomeDelegate: AnyObject {
    func didSomething()
}

class SomeClass {
    weak var delegate: SomeDelegate?

    func performTask() {
        //Task Implementation
        delegate?.didSomething()
    }
    class AnotherClass: SomeDelegate {
        let someObject = SomeClass()

        init() {
            someObject.delegate = self
        }
        func didSomething() {
            //Handle the event
        }
    }
}
///--------------------------------------------------------------------------------------
/*
 Closure: A closure is an **anonymous function** that can be passed around and executed later. Closures can capture and store references to variables from their surrounding context, allowing them to retain state even after the original scope has changed.

 Capture List: A capture list allows us to control how values are captured and used inside a closure. It helps prevent memory leaks by specifying whether variables should be captured strongly, weakly, or unowned, especially when working with reference types like classes.
*/

/// Value Type Closure
var a = 10
a = 20

var closure = { [a](val: Int) in   //| The value of the closure is set originally as 10
    print("val = \(val)")          //| the capture list captures the value at the moment
    print("a = \(a)")              //| the closure is created, even though a changes to
}                                  //| 90, the closure still holds the original value

a = 90

closure(100)

/// Reference Type Closure
class Test {                        //| The values is set originally at 89
    var unit: Int = 89              //| because this is a reference value,
}                                   //| we are modifyng the same memory address
                                    //| therefore, once the closure captures the value
var obj = Test()                    //| it will capture the latest values that is set
var closureForClass = { [obj] in    //| in this case, the value has changed to 1
    print(obj.unit)                 //| and it will be the value that are going to
}                                   //| be used
obj.unit = 1                        //|
closureForClass()                   //|
///--------------------------------------------------------------------------------------
/// Optional Chaining
/*
Optional chaining: It's a simplified syntax for reading optionals or multiple optional values instead of unwraping them manually. It's rarely used but it's useful to have, basically if the optional have value run some code but, if it's empty, return nil or we can also use coalescing notation for assigning a default value.

Coalescing Notation: It is used for unwrapping optional values, it is useful because instead of having a nil or empty value, if it's nil, we can assign a default value instead of having a nil.
*/

let names = ["Arya", "Bran", "Edgar","Armando"]
let chosen = names.randomElement()?.uppercased() ?? "No Name"
print("Next in line: \(chosen)")

/// Handle Multiple Conditional Values
struct Book {
    let title: String
    let author: String?
}

var book: Book? = nil
let author = book?.author?.uppercased() ?? "No Author"
print(author)
///--------------------------------------------------------------------------------------
/// Solid Principles
/*
 S
Stands for Single Responsability, each class should have one reason to change, meaning it should be responsible for a single part of the functionality. This does not mean it should only perform one task, but that all its responsibilities should be closely related.b.
 O
Stands for Open/Closed this principle says that Classes should be open for extension but closed for modification. This means we should be able to add new functionality without altering existing code, often achieved using inheritance or protocols.
 L
Stands for Lizkov Substitution a subclass should be able to replace its parent class without breaking the application. If a derived class modifies behavior in a way that makes the parent class unusable, it violates this principle.
 I
Stands for Interface Segregation Classes should not be forced to implement methods they do not use. Instead of large, general-purpose interfaces (or protocols), it’s better to have smaller, more specific ones to avoid unnecessary dependencies.
 D
Stands for Dependency Inversion and means that High-level modules should not depend on low-level modules, but both should depend on abstractions. This reduces tight coupling and makes the code more flexible and maintainable.*/
