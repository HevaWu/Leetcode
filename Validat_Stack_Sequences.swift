// Given two sequences pushed and popped with distinct values, return true if and only if this could have been the result of a sequence of push and pop operations on an initially empty stack.

 

// Example 1:

// Input: pushed = [1,2,3,4,5], popped = [4,5,3,2,1]
// Output: true
// Explanation: We might do the following sequence:
// push(1), push(2), push(3), push(4), pop() -> 4,
// push(5), pop() -> 5, pop() -> 3, pop() -> 2, pop() -> 1
// Example 2:

// Input: pushed = [1,2,3,4,5], popped = [4,3,5,1,2]
// Output: false
// Explanation: 1 cannot be popped before 2.
 

// Note:

// 0 <= pushed.length == popped.length <= 1000
// 0 <= pushed[i], popped[i] < 1000
// pushed is a permutation of popped.
// pushed and popped have distinct values.

// Solution 1: simulate stack
// 
// Time complexity: O(2n)
// Space complexity: O(n)
class Solution {
    func validateStackSequences(_ pushed: [Int], _ popped: [Int]) -> Bool {
        guard !pushed.isEmpty, !popped.isEmpty else { return true }
        var stack = [Int]()
        
        var popIndex = 0
        var pushIndex = 0
        while popIndex < popped.count {
            if let last = stack.last, last == popped[popIndex] {
                // pop this element in stack
                stack.removeLast()
                popIndex += 1
            } else {
                guard pushIndex < pushed.count else { break }
                // push this element in stack 
                stack.append(pushed[pushIndex])
                pushIndex += 1
            }
        }
        return true
    }
}