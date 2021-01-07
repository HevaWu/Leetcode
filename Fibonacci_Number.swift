/*
The Fibonacci numbers, commonly denoted F(n) form a sequence, called the Fibonacci sequence, such that each number is the sum of the two preceding ones, starting from 0 and 1. That is,

F(0) = 0, F(1) = 1
F(n) = F(n - 1) + F(n - 2), for n > 1.
Given n, calculate F(n).

 

Example 1:

Input: n = 2
Output: 1
Explanation: F(2) = F(1) + F(0) = 1 + 0 = 1.
Example 2:

Input: n = 3
Output: 2
Explanation: F(3) = F(2) + F(1) = 1 + 1 = 2.
Example 3:

Input: n = 4
Output: 3
Explanation: F(4) = F(3) + F(2) = 2 + 1 = 3.
 

Constraints:

0 <= n <= 30

*/

/*
Solution 3:
golden ratio
Binet's forumula: φ= (1+Root5)/2≈1.6180339887....

Time Complexity: O(1)
Space Complexity: O(1)
*/
import Darwin
func fib(_ n: Int) -> Int {
    if n<=1 { return n }
    let goldenRatio: Double = (1+Double(5).squareRoot())/2
    return Int((pow(goldenRatio, Double(n))/Double(5).squareRoot()).rounded())
}

/*
Solution 2:
Math, matrix exponentiation

N-th Fibonacci number ((1,1)(1,0))^n = ((Fn+1, Fn),(Fn, Fn-1))

TimeComplexity: O(logn)
SpaceComplexity: O(logn)
*/
class Solution {
    func fib(_ n: Int) -> Int {
        if n <= 1 { return n }
        var A = [[1, 1], [1,0]]
        matrixPower(&A, n-1)
        return A[0][0]
    }
    
    func matrixPower(_ A: inout [[Int]], _ n: Int) {
        if n <= 1 { return }
        matrixPower(&A, n/2)
        multiply(&A, A)
        
        var B = [[1, 1], [1, 0]]
        if n%2 != 0 {
            multiply(&A, B)
        }
    }
    
    func multiply(_ A: inout [[Int]], _ B: [[Int]]) {
        let x = A[0][0] * B[0][0] + A[0][1] * B[1][0]
        let y = A[0][0] * B[0][1] + A[0][1] * B[1][1]
        let z = A[1][0] * B[0][0] + A[1][1] * B[1][0]
        let w = A[1][0] * B[0][1] + A[1][1] * B[1][1]
        
        A[0][0] = x
        A[0][1] = y
        A[1][0] = z
        A[1][1] = w
    }
}

/*
Solution 1:
recursive

use cache to memo previous counted number

Time Complexity: O(n) -> each number will only count as once
Space Complexity: O(n) -> store cache
*/
class Solution {
    func fib(_ n: Int) -> Int {
        // key is number n
        // value is F(n): Fibonacci value
        var cache = [Int: Int]()
        
        cache[0] = 0
        cache[1] = 1
        
        func _fib(_ num: Int) -> Int {
            if let val = cache[num] { return val }
            cache[num-1] = _fib(num-1)
            cache[num-2] = _fib(num-2)
            return cache[num-1]! + cache[num-2]!
        }
        
        return _fib(n)
    }
}