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

 Race Condition: Happens when the order of events affects the correctnessof a piece of code

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
