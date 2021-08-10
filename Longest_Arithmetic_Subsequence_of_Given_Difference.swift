/*
Given an integer array arr and an integer difference, return the length of the longest subsequence in arr which is an arithmetic sequence such that the difference between adjacent elements in the subsequence equals difference.

A subsequence is a sequence that can be derived from arr by deleting some or no elements without changing the order of the remaining elements.



Example 1:

Input: arr = [1,2,3,4], difference = 1
Output: 4
Explanation: The longest arithmetic subsequence is [1,2,3,4].
Example 2:

Input: arr = [1,3,5,7], difference = 1
Output: 1
Explanation: The longest arithmetic subsequence is any single element.
Example 3:

Input: arr = [1,5,7,8,5,3,4,2,1], difference = -2
Output: 4
Explanation: The longest arithmetic subsequence is [7,5,3,1].


Constraints:

1 <= arr.length <= 105
-104 <= arr[i], difference <= 104
*/

/*
Solution 1:
map
key is last element in subsequence
val is current subsequence length

iterate arr, and try to see if num-difference exist or not
if there is any last sequence there, we add 1 to that sequence, and update the map
if no, and current num is not appear in map before, set current num as 1

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func longestSubsequence(_ arr: [Int], _ difference: Int) -> Int {
        let n = arr.count
        if n == 1 { return 1 }

        // key is last element in subsequence
        // val is current subsequence length
        var map = [Int: Int]()

        for num in arr {
            let last = num-difference
            if let val = map[last] {
                map[last] = nil
                map[num] = val+1
            } else if map[num] == nil {
                // only update it to 1 when num not happen before
                map[num] = 1
            }
            // print(num, map[num])
        }

        var longest = 0
        for v in map.values {
            longest = max(longest, v)
        }
        return longest
    }
}