/*
Given a collection of numbers, nums, that might contain duplicates, return all possible unique permutations in any order.



Example 1:

Input: nums = [1,1,2]
Output:
[[1,1,2],
 [1,2,1],
 [2,1,1]]
Example 2:

Input: nums = [1,2,3]
Output: [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]


Constraints:

1 <= nums.length <= 8
-10 <= nums[i] <= 10
*/

/*
Solution 1:
backtrack

put num and freq into map
then insert number by sorted keys

Time Complexity: O(n!)
Space Complexity: O(n)
*/
class Solution {
    func permuteUnique(_ nums: [Int]) -> [[Int]] {
        var per = [[Int]]()
        var cur = [Int]()
        var map = [Int: Int]()
        for num in nums {
            map[num, default: 0] += 1
        }

        let n = nums.count
        backtrack(n, &map, &cur, &per)
        return Array(per)
    }

    func backtrack(
        _ n: Int,
        _ map: inout [Int: Int],
        _ cur: inout [Int], _ per: inout [[Int]]
    ) {
        if cur.count == n {
            per.append(cur)
            return
        }

        for num in map.keys {
            guard let val = map[num], val > 0 else {
                continue
            }

            cur.append(num)
            map[num] = val-1

            backtrack(n, &map, &cur, &per)

            cur.removeLast()
            map[num] = val
        }
    }
}