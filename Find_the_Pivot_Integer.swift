/*
Given a positive integer n, find the pivot integer x such that:

The sum of all elements between 1 and x inclusively equals the sum of all elements between x and n inclusively.
Return the pivot integer x. If no such integer exists, return -1. It is guaranteed that there will be at most one pivot index for the given input.



Example 1:

Input: n = 8
Output: 6
Explanation: 6 is the pivot integer since: 1 + 2 + 3 + 4 + 5 + 6 = 6 + 7 + 8 = 21.
Example 2:

Input: n = 1
Output: 1
Explanation: 1 is the pivot integer since: 1 = 1.
Example 3:

Input: n = 4
Output: -1
Explanation: It can be proved that no such integer exist.


Constraints:

1 <= n <= 1000
*/

/*
Solution 1:
two pointer to check left part and right part sum

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func pivotInteger(_ n: Int) -> Int {
        if n == 1 { return 1 }
        var l = 0
        var r = 0
        var il = 1
        var ir = n
        while il < ir {
            while il < ir, l < r {
                l += il
                il += 1
            }
            if il == ir, l == r {
                return ir
            }
            r += ir
            ir -= 1
        }
        // print(ir, il, l, r)
        return -1
    }
}
