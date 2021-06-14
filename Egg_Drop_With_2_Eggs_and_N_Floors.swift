/*
You are given two identical eggs and you have access to a building with n floors labeled from 1 to n.

You know that there exists a floor f where 0 <= f <= n such that any egg dropped at a floor higher than f will break, and any egg dropped at or below floor f will not break.

In each move, you may take an unbroken egg and drop it from any floor x (where 1 <= x <= n). If the egg breaks, you can no longer use it. However, if the egg does not break, you may reuse it in future moves.

Return the minimum number of moves that you need to determine with certainty what the value of f is.



Example 1:

Input: n = 2
Output: 2
Explanation: We can drop the first egg from floor 1 and the second egg from floor 2.
If the first egg breaks, we know that f = 0.
If the second egg breaks but the first egg didn't, we know that f = 1.
Otherwise, if both eggs survive, we know that f = 2.
Example 2:

Input: n = 100
Output: 14
Explanation: One optimal strategy is:
- Drop the 1st egg at floor 9. If it breaks, we know f is between 0 and 8. Drop the 2nd egg starting
  from floor 1 and going up one at a time to find f within 7 more drops. Total drops is 1 + 7 = 8.
- If the 1st egg does not break, drop the 1st egg again at floor 22. If it breaks, we know f is between 9
  and 21. Drop the 2nd egg starting from floor 10 and going up one at a time to find f within 12 more
  drops. Total drops is 2 + 12 = 14.
- If the 1st egg does not break again, follow a similar process dropping the 1st egg from floors 34, 45,
  55, 64, 72, 79, 85, 90, 94, 97, 99, and 100.
Regardless of the outcome, it takes at most 14 drops to determine f.


Constraints:

1 <= n <= 1000
*/

/*
Solution 2:
math

x + (x - 1) + (x - 2) + ... + 2 + 1 >= n equation (when you have two eggs)

Time Complexity: O(1)
Space Complexity: O(1)
*/
class Solution {
    func twoEggDrop(_ n: Int) -> Int {
        return Int(ceil((sqrt(Double(1 + 8*n)) - 1) / 2))
    }
}

/*
Solution 1:
DP
If you drop an egg from i floor (1<=i<=n), then
- If the egg breaks, the problem is reduced to x-1 eggs and i - 1 floors
- If the eggs does not break, the problem is reduced to x eggs and n-i floors

Time Complexity: O()
*/
class Solution {
    func twoEggDrop(_ n: Int) -> Int {
        // (int) Math.ceil((Math.sqrt(1 + 8 * n) - 1) / 2);
        var dp = Array(
            repeating: Array(repeating: 0, count: 3),
            count: n+1
        )
        return drop(n, 2, &dp)
    }

    func drop(_ floors: Int, _ eggs: Int, _ dp: inout [[Int]]) -> Int {
        if eggs == 1 || floors <= 1 { return floors }
        if dp[floors][eggs] > 0 { return dp[floors][eggs] }
        var min_val = Int.max
        for f in 1...floors {
            min_val = min(
                min_val,
                1 + max(
                    drop(f-1, eggs-1, &dp),
                    drop(floors-f, eggs, &dp)
                )
            )
        }
        dp[floors][eggs] = min_val
        return min_val
    }
}