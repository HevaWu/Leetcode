/*
Find all valid combinations of k numbers that sum up to n such that the following conditions are true:

Only numbers 1 through 9 are used.
Each number is used at most once.
Return a list of all possible valid combinations. The list must not contain the same combination twice, and the combinations may be returned in any order.



Example 1:

Input: k = 3, n = 7
Output: [[1,2,4]]
Explanation:
1 + 2 + 4 = 7
There are no other valid combinations.
Example 2:

Input: k = 3, n = 9
Output: [[1,2,6],[1,3,5],[2,3,4]]
Explanation:
1 + 2 + 6 = 9
1 + 3 + 5 = 9
2 + 3 + 4 = 9
There are no other valid combinations.
Example 3:

Input: k = 4, n = 1
Output: []
Explanation: There are no valid combinations. [1,2,1] is not valid because 1 is used twice.
Example 4:

Input: k = 3, n = 2
Output: []
Explanation: There are no valid combinations.
Example 5:

Input: k = 9, n = 45
Output: [[1,2,3,4,5,6,7,8,9]]
Explanation:
1 + 2 + 3 + 4 + 5 + 6 + 7 + 8 + 9 = 45
​​​​​​​There are no other valid combinations.


Constraints:

2 <= k <= 9
1 <= n <= 60
*/

/*
Solution 1:
backTrack

Time Complexity: O(9!)
Space Complexity: O(9)
*/
class Solution {
    func combinationSum3(_ k: Int, _ n: Int) -> [[Int]] {
        var res = [[Int]]()
        var cur = [Int]()
        check(k, n, 1, 9, &cur, &res)
        return res
    }

    func check(_ k: Int, _ n: Int,
               _ start: Int, _ end: Int,
               _ cur: inout [Int], _ res: inout [[Int]]) {
        if k == 0, n == 0 {
            res.append(cur)
            return
        }

        // Note: check if start > end
        if k == 0 || n == 0 || start > end {
            return
        }

        for i in start...end {
            if n >= i {
                // pick i
                cur.append(i)
                check(k-1, n-i, i+1, end, &cur, &res)
                cur.removeLast()
            }
        }
    }
}