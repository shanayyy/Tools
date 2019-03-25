import XCTest
import Tools

class Tests: XCTestCase {
    var store = ThreadSafeStore(independentAccess: false)
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        DispatchQueue.concurrentPerform(iterations: 10) { (idx) in
            
            self.store.setItem((self.store.getItem(forKey: "key1") ?? 0) + 1, forKey: "key1")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let i: Int? = self.store.getItem(forKey: "key1")
            XCTAssert(i == 10, "\(i)")
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
