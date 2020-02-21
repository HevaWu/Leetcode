// Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.

// push(x) -- Push element x onto stack.
// pop() -- Removes the element on top of the stack.
// top() -- Get the top element.
// getMin() -- Retrieve the minimum element in the stack.
 

// Example:

// MinStack minStack = new MinStack();
// minStack.push(-2);
// minStack.push(0);
// minStack.push(-3);
// minStack.getMin();   --> Returns -3.
// minStack.pop();
// minStack.top();      --> Returns 0.
// minStack.getMin();   --> Returns -2.

// Hint
// Consider each node in the stack having a minimum value.

// Solution 1: Stack pairs
// always kep [cur, minimum] pair for each push
// n addition to putting a number on an underlying Stack inside our MinStack, we could also put its corresponding minimum value alongside it. Then whenever that particular number is at the top of the underlying Stack, the getTop(...) operation of MinStack is as simple as retrieving its corresponding minimum value.
// when we put a new number on the underlying Stack, we need to decide whether the minimum at that point is the new number itself, or whether it's the minimum before. It makes sense that it would always be the smallest of these two values.
// 
// Time Complexity : O(1)O(1) for all operations.
// push(...): Checking the top of a Stack, comparing numbers, and pushing to the top of a Stack (or adding to the end of an Array or List) are all O(1)O(1) operations. Therefore, this overall is an O(1)O(1) operation.
// pop(...): Popping from a Stack (or removing from the end of an Array, or List) is an O(1)O(1) operation.
// top(...): Looking at the top of a Stack is an O(1)O(1) operation.
// getMin(...): Same as above. This operation is O(1)O(1) because we do not need to compare values to find it. If we had not kept track of it on the Stack, and instead had to search for it each time, the overall time complexity would have been O(n)O(n).
// 
// Space Complexity : O(n)O(n).
// Worst case is that all the operations are push. In this case, there will be O(2 \cdot n) = O(n)O(2⋅n)=O(n) space used.
class MinStack {
    // pair, first is current calue, second is correspond minimum one
    var minArr = [(Int, Int)]()

    /** initialize your data structure here. */
    init() {
        
    }
    
    func push(_ x: Int) {
        guard !minArr.isEmpty else { 
            minArr.append((x, x))
            return
        }
        let last = minArr[minArr.count-1]
        minArr.append((x, min(x, last.1)))
    }
    
    func pop() {
        minArr.removeLast()
    }
    
    func top() -> Int {
        return minArr[minArr.count-1].0
    }
    
    func getMin() -> Int {
        return minArr[minArr.count-1].1
    }
}

/**
 * Your MinStack object will be instantiated and called as such:
 * let obj = MinStack()
 * obj.push(x)
 * obj.pop()
 * let ret_3: Int = obj.top()
 * let ret_4: Int = obj.getMin()
 */


// Solution 2: Two Stacks
// There's another, somewhat different approach to implementing a MinStack. Approach 1 required storing two values in each slot of the underlying Stack. Sometimes though, the minimum values are very repetitive. Do we actually need to store the same minimum value over and over again?
// Turns out we don't—we could instead have two Stackss inside our MinStack. The main Stack should keep track of the order numbers arrived (a standard Stack), and the second Stack should keep track of the current minimum. We'll call this second Stack the "min-tracker" Stack for clarity.
// 
// While 6 was already at the top of the min-tracker Stack, we pushed another 6 onto the MinStack. Because this new 6 was equal to the current minimum, it didn't change what the current minimum was, and therefore wasn't pushed. At first, this worked okay.
// The way we can solve this is a small modification to the MinStack's push(...) method. Instead of only pushing numbers to the min-tracker Stack if they are less than the current minimum, we should push them if they are less than or equal to it. While this means that some duplicates are added to the min-tracker Stack, the bug will no longer occur. Here is another animation with the same test case as above, but the bug fixed.
// 
// Let nn be the total number of operations performed.
// Time Complexity : O(1)O(1) for all operations.
// Same as above. All our modifications are still O(1)O(1).
// Space Complexity : O(n)O(n).

class MinStack {
    // stack handle the minum number 
    var minArr = [Int]()
    
    // the stack for handle all element 
    var stack = [Int]()

    /** initialize your data structure here. */
    init() {
        
    }
    
    func push(_ x: Int) {
        stack.append(x)
        guard !minArr.isEmpty else {
            minArr.append(x)
            return
        }
        if x <= minArr.last! {
            minArr.append(x)
        }
    }
    
    func pop() {
        let last = stack.removeLast()
        if minArr.last == last {
            minArr.removeLast()
        }
    }
    
    func top() -> Int {
        return stack.last!
    }
    
    func getMin() -> Int {
        return minArr.last!
    }
}

/**
 * Your MinStack object will be instantiated and called as such:
 * let obj = MinStack()
 * obj.push(x)
 * obj.pop()
 * let ret_3: Int = obj.top()
 * let ret_4: Int = obj.getMin()
 */

// Solution 3: improved Two Stacks 
// An improvement is to put pairs onto the min-tracker Stack. The first value of the pair would be the same as before, and the second value would be how many times that minimum was repeated. For example, this is how the min-tracker Stack for the example just above would appear.

