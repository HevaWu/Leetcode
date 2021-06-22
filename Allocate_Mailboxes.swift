/*
Given the array houses and an integer k. where houses[i] is the location of the ith house along a street, your task is to allocate k mailboxes in the street.

Return the minimum total distance between each house and its nearest mailbox.

The answer is guaranteed to fit in a 32-bit signed integer.



Example 1:



Input: houses = [1,4,8,10,20], k = 3
Output: 5
Explanation: Allocate mailboxes in position 3, 9 and 20.
Minimum total distance from each houses to nearest mailboxes is |3-1| + |4-3| + |9-8| + |10-9| + |20-20| = 5
Example 2:



Input: houses = [2,3,5,12,18], k = 2
Output: 9
Explanation: Allocate mailboxes in position 3 and 14.
Minimum total distance from each houses to nearest mailboxes is |2-3| + |3-3| + |5-3| + |12-14| + |18-14| = 9.
Example 3:

Input: houses = [7,4,6,1], k = 1
Output: 8
Example 4:

Input: houses = [3,6,14,10], k = 4
Output: 0


Constraints:

n == houses.length
1 <= n <= 100
1 <= houses[i] <= 10^4
1 <= k <= n
Array houses contain unique integers.
*/

/*
Solution 1:
DP

If k =1, the minimum distance is obtained allocating the mailbox in the median of the array houses.
general it:
- first, use costs[i][j] to record the distance if we put mailbox among houses[i...j]
- use dp[i][k] to memorize if we put k mailbox in [0...i] houses
=> dfs to check if we can minimize distance to put k mailbox

Time Complexity: O(n^3)
Space Complexity: O(n^2)
*/
class Solution {
    func minDistance(_ houses: [Int], _ k: Int) -> Int {
        var houses = houses.sorted()
        let n = houses.count

        // cost to put mailbox among houses[i...j], best way is put it at median of houses[i...j]
        var costs = Array(
            repeating: Array(repeating: 0, count: n),
            count: n
        )

        for i in 0..<n {
            for j in i..<n {
                let mid = houses[(i+j) / 2]
                for t in i...j {
                    costs[i][j] += abs(mid - houses[t])
                }
            }
        }

        let MAX_DIS = 100*10000
        var dp: [[Int?]] = Array(
            repeating: Array(repeating: nil, count: k+1),
            count: n+1
        )

        func check(_ index: Int, _ k: Int) -> Int {
            if k == 0, index == n { return 0 }
            if k == 0 || index == n { return MAX_DIS }
            if let val = dp[index][k] { return val }

            var val = MAX_DIS
            for i in index..<n {
                // if we put one mailbox between houses[index...i], remaining would be dp(i+1, k-1)
                let cost = costs[index][i]
                val = min(val, cost + check(i+1, k-1))
            }
            dp[index][k] = val
            return val
        }

        return check(0, k)
    }
}