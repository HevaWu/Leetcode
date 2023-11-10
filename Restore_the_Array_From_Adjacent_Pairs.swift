/*
There is an integer array nums that consists of n unique elements, but you have forgotten it. However, you do remember every pair of adjacent elements in nums.

You are given a 2D integer array adjacentPairs of size n - 1 where each adjacentPairs[i] = [ui, vi] indicates that the elements ui and vi are adjacent in nums.

It is guaranteed that every adjacent pair of elements nums[i] and nums[i+1] will exist in adjacentPairs, either as [nums[i], nums[i+1]] or [nums[i+1], nums[i]]. The pairs can appear in any order.

Return the original array nums. If there are multiple solutions, return any of them.



Example 1:

Input: adjacentPairs = [[2,1],[3,4],[3,2]]
Output: [1,2,3,4]
Explanation: This array has all its adjacent pairs in adjacentPairs.
Notice that adjacentPairs[i] may not be in left-to-right order.
Example 2:

Input: adjacentPairs = [[4,-2],[1,4],[-3,1]]
Output: [-2,4,1,-3]
Explanation: There can be negative numbers.
Another solution is [-3,1,4,-2], which would also be accepted.
Example 3:

Input: adjacentPairs = [[100000,-100000]]
Output: [100000,-100000]


Constraints:

nums.length == n
adjacentPairs.length == n - 1
adjacentPairs[i].length == 2
2 <= n <= 105
-105 <= nums[i], ui, vi <= 105
There exists some nums that has adjacentPairs as its pairs.
*/

/*
Solution 1:
go through pairs to find the head of array
to be head of array, its adjacent node should only have one

From the head, try to find its connected next number
use visited to mark if this number already been added in to array or not

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func restoreArray(_ adjacentPairs: [[Int]]) -> [Int] {
        var adj = [Int: [Int]]()
        for pair in adjacentPairs {
            adj[pair[0], default:[Int]()].append(pair[1])
            adj[pair[1], default:[Int]()].append(pair[0])
        }

        var cur = 1000_001
        // find the result array's head
        for k in adj.keys {
            if adj[k, default:[Int]()].count == 1 {
                cur = k
                break
            }
        }

        var res = [Int]()
        // record if number already in array or not
        var visited = Set<Int>()
        visited.insert(cur)
        while true {
            res.append(cur)
            let tmp = cur
            if let list = adj[cur] {
                for next in list {
                    if !visited.contains(next) {
                        cur = next
                        visited.insert(next)
                    }
                }
            }

            if tmp == cur {
                // no further next found
                break
            }
        }
        return res
    }
}
