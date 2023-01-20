/*
Given an integer array nums, return all the different possible non-decreasing subsequences of the given array with at least two elements. You may return the answer in any order.



Example 1:

Input: nums = [4,6,7,7]
Output: [[4,6],[4,6,7],[4,6,7,7],[4,7],[4,7,7],[6,7],[6,7,7],[7,7]]
Example 2:

Input: nums = [4,4,3,2,1]
Output: [[4,4]]


Constraints:

1 <= nums.length <= 15
-100 <= nums[i] <= 100
*/

/*
Solution 1:
check all possible subsequence

Time Complexity: O(n!)
Space Complexity: O(n!)
*/
class Solution {
    func findSubsequences(_ nums: [Int]) -> [[Int]] {
        var res = Set<[Int]>()
        let n = nums.count
        check(0, n, nums, &res)
        return Array(res)
    }

    func check(_ index: Int, _ n : Int, _ nums: [Int],
    _ res: inout Set<[Int]>) {
        if index == n { return }
        for pre in res {
            if nums[index] >= pre.last! {
                let temp = pre + [nums[index]]
                res.insert(temp)
            }
        }
        for j in 0..<index {
            if nums[j] <= nums[index] {
                res.insert([nums[j], nums[index]])
            }
        }

        check(index+1, n, nums, &res)
    }
}
