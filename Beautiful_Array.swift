/*
For some fixed n, an array nums is beautiful if it is a permutation of the integers 1, 2, ..., n, such that:

For every i < j, there is no k with i < k < j such that nums[k] * 2 = nums[i] + nums[j].

Given n, return any beautiful array nums.  (It is guaranteed that one exists.)



Example 1:

Input: n = 4
Output: [2,1,4,3]
Example 2:

Input: n = 5
Output: [3,1,2,5,4]


Note:

1 <= n <= 1000

*/

/*
Solution 1:

One way is to guess that we should divide and conquer. One reason for this is that the condition is linear, so if the condition is satisfied by variables taking on values (1, 2, ..., n), it is satisfied by those variables taking on values (a + b, a + 2*b, a + 3*b, ..., a + (n-1)*b) instead.

If we perform a divide and conquer, then we have two parts left and right, such that each part is arithmetic-free, and we only want that a triple from both parts is not arithmetic. Looking at the conditions:

2*A[k] = A[i] + A[j]
(i < k < j), i from left, j from right
we can guess that because the left hand side 2*A[k] is even, we can choose left to have all odd elements, and right to have all even elements.

Looking at the elements 1, 2, ..., N, there are (N+1) / 2 odd numbers and N / 2 even numbers.

We solve for elements 1, 2, ..., (N+1) / 2 and map these numbers onto 1, 3, 5, .... Similarly, we solve for elements 1, 2, ..., N/2 and map these numbers onto 2, 4, 6, ....

We can compose these solutions by concatenating them, since an arithmetic sequence never starts and ends with elements of different parity.

We memoize the result to arrive at the answer quicker.

Time Complexity: O(n)
Space Complexity: O(n*n)
*/
class Solution {
    func beautifulArray(_ n: Int) -> [Int] {
        var memo = [Int: [Int]]()
        return f(n, &memo)
    }

    func f(_ n: Int, _ memo: inout [Int: [Int]]) -> [Int] {
        if let val = memo[n] { return val }
        var val = Array(repeating: 0, count: n)
        if n == 1 {
            val[0] = 1
        } else {
            var i = 0
            for x in f((n+1)/2, &memo) {
                // odd numbers
                val[i] = 2*x - 1
                i += 1
            }
            for x in f(n/2, &memo) {
                // even numbers
                val[i] = 2*x
                i += 1
            }
        }
        memo[n] = val
        return val
    }
}