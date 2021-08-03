/*
Given an integer array nums that may contain duplicates, return all possible subsets (the power set).

The solution set must not contain duplicate subsets. Return the solution in any order.



Example 1:

Input: nums = [1,2,2]
Output: [[],[1],[1,2],[1,2,2],[2],[2,2]]
Example 2:

Input: nums = [0]
Output: [[],[0]]


Constraints:

1 <= nums.length <= 10
-10 <= nums[i] <= 10
*/

/*
Solution 2:
improve solution 1

sort nums first to help reducing time complexity

Time Complexity: O(nlogn + 2^n)
Space Complexity: O(n)
*/
class Solution {
    func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
        var subset = Set<[Int]>()
        let n = nums.count
        var nums = nums.sorted()

        check(0, n, [Int](), &subset, nums)
        return Array(subset)
    }

    func check(_ index: Int, _ n: Int, _ cur: [Int],
               _ subset: inout Set<[Int]>, _ nums: [Int]) {
        if index == n {
            subset.insert(cur)
            return
        }

        check(index+1, n, cur, &subset, nums)
        check(index+1, n, cur+[nums[index]], &subset, nums)
    }
}

/*
Solution 1:
backTrack

recursively pick current element or not
use Set<[Int]> to make sure no duplicate components

Time Complexity: O(2^n*(klogk))
Space Complexity: O(n)
*/
class Solution {
    func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
        let n = nums.count
        var res = Set<[Int]>()
        var cur = [Int]()
        check(nums, 0, n, &cur, &res)
        return Array(res)
    }

    func check(_ nums: [Int], _ index: Int, _ n: Int,
               _ cur: inout [Int], _ res: inout Set<[Int]>) {
        // sorted, [1,4,4] equal to [4,1,4]
        res.insert(cur.sorted())

        if index == n { return }
        for i in index..<n {
            cur.append(nums[i])
            check(nums, i+1, n, &cur, &res)
            cur.removeLast()
        }
    }
}