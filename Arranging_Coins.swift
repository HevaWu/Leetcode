/*
You have n coins and you want to build a staircase with these coins. The staircase consists of k rows where the ith row has exactly i coins. The last row of the staircase may be incomplete.

Given the integer n, return the number of complete rows of the staircase you will build.



Example 1:


Input: n = 5
Output: 2
Explanation: Because the 3rd row is incomplete, we return 2.
Example 2:


Input: n = 8
Output: 3
Explanation: Because the 4th row is incomplete, we return 3.


Constraints:

1 <= n <= 231 - 1
*/

/*
Solution 2:
math
k = \left[\sqrt{2N + \frac{1}{4}} - \frac{1}{2}\right]

Time Complexity: O(1)
Space Complexity: O(1)
*/
class Solution {
    func arrangeCoins(_ n: Int) -> Int {
        return Int(sqrt(Double(2*n) + 0.25) - 0.5)
    }
}

/*
Solution 1:
calculate sum

k(k+1)≤2N

Idea:
- find sqrt(2*n) first
- then check we can go left or right

Time Complexity: O(1)
Space Complexity: O(1)
*/
class Solution {
    func arrangeCoins(_ n: Int) -> Int {
        // find min x where x*(x+1) >= 2*n
        let val = 2*n
        let root = Int(sqrt(Double(val)))

        var x = root
        while x*(x+1) >= val {
            x -= 1
        }
        // print(x, root)

        // total x+1 row
        // if x+1 row also complete, return x+1
        // else, return x
        if x != root { return (x+1)*(x+2) == val ? x+1 : x }
        while x*(x+1) <= val {
            x += 1
        }

        // total x row
        // if x row also complete, return x
        // else, return x-1
        return x*(x+1) == val ? x : x-1
    }
}