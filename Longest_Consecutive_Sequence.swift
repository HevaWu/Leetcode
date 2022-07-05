/*
Given an unsorted array of integers, find the length of the longest consecutive elements sequence.

Your algorithm should run in O(n) complexity.

Example:

Input: [100, 4, 200, 1, 3, 2]
Output: 4
Explanation: The longest consecutive elements sequence is [1, 2, 3, 4]. Therefore its length is 4.
*/

/*
Solution 1:
map
- map[i] is the number of element in consecutive path with boundary at i
- go through num
  - if there is a value there, means this num is counted
  - if there is no value there, try to find its left(num-1) and right(num+1) consecutive path, then put it into map, also need to update the boundary number in the map

Time complexity: O(n)
Space complexity: O(n)
*/
class Solution {
    func longestConsecutive(_ nums: [Int]) -> Int {
        guard !nums.isEmpty else { return 0 }

        var count = 0

        // map[i], current consecutive path contains nums[i]
        var map = [Int: Int]()

        for num in nums {
            if let _ = map[num] {
                // this one already counted
                continue
            } else {
                check num-1 & num+1
                var left = map[num-1, default: 0]
                var right = map[num+1, default: 0]
                var temp = left + right + 1

                map[num] = temp
                count = max(count, map[num]!)

                // update left & right bound
                map[num-left] = temp
                map[num+right] = temp
            }
        }
        return count
    }
}