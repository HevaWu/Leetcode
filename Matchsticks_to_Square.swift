/*
You are given an integer array matchsticks where matchsticks[i] is the length of the ith matchstick. You want to use all the matchsticks to make one square. You should not break any stick, but you can link them up, and each matchstick must be used exactly one time.

Return true if you can make this square and false otherwise.



Example 1:


Input: matchsticks = [1,1,2,2,2]
Output: true
Explanation: You can form a square with length 2, one side of the square came two sticks with length 1.
Example 2:

Input: matchsticks = [3,3,3,3,4]
Output: false
Explanation: You cannot find a way to form a square with all the matchsticks.


Constraints:

1 <= matchsticks.length <= 15
0 <= matchsticks[i] <= 109
*/

/*
Solution 1:
backtrack
dfs

for each sticks, check which arr we can put it into

Time Complexity: O(4^n)
Space Complexity: O(1)
*/
class Solution {
    func makesquare(_ matchsticks: [Int]) -> Bool {
        let sum = matchsticks.reduce(into: 0) { res, next in
            res += next
        }

        if sum % 4 != 0 { return false }
        let len = sum / 4

        var matchsticks = matchsticks.sorted(by: >)
        var arr = Array(repeating: 0, count: 4)
        var canMake = false

        let n = matchsticks.count
        check(0, n, matchsticks, len, &arr, &canMake)
        return canMake
    }

    func check(_ index: Int, _ n: Int,
               _ matchsticks: [Int], _ len: Int,
               _ arr: inout [Int], _ canMake: inout Bool) {
        guard !canMake else { return }

        guard index < n else {
            for ele in arr {
                if ele != len {
                    return
                }
            }
            canMake = true
            return
        }

        for j in 0..<4 {
            if matchsticks[index] + arr[j] <= len {
                // try to put ith stick in arr[j]
                arr[j] += matchsticks[index]
                check(index+1, n, matchsticks, len, &arr, &canMake)
                arr[j] -= matchsticks[index]
            }
        }
    }
}