/*
Given two sequences pushed and popped with distinct values, return true if and only if this could have been the result of a sequence of push and pop operations on an initially empty stack.

 

Example 1:

Input: pushed = [1,2,3,4,5], popped = [4,5,3,2,1]
Output: true
Explanation: We might do the following sequence:
push(1), push(2), push(3), push(4), pop() -> 4,
push(5), pop() -> 5, pop() -> 3, pop() -> 2, pop() -> 1
Example 2:

Input: pushed = [1,2,3,4,5], popped = [4,3,5,1,2]
Output: false
Explanation: 1 cannot be popped before 2.
 

Constraints:

0 <= pushed.length == popped.length <= 1000
0 <= pushed[i], popped[i] < 1000
pushed is a permutation of popped.
pushed and popped have distinct values.
*/

/*
Solution 1:
stack
greedy

use stack to check if pushed & popped logic can be correct

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func validateStackSequences(_ pushed: [Int], _ popped: [Int]) -> Bool {
        if pushed.isEmpty && popped.isEmpty { return true }
        
        let n = pushed.count
        var i_push = 0
        var i_pop = 0
        var stack = [Int]()
        
        while i_push < n {
            stack.append(pushed[i_push])
            
            while i_pop < n, popped[i_pop] == stack.last {
                stack.removeLast()
                i_pop += 1
            }
            
            i_push += 1
        }
        
        // print(stack)
        return stack.isEmpty
    }
}