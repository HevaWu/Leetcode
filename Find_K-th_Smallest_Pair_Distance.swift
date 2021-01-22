/*
Given an integer array, return the k-th smallest distance among all the pairs. The distance of a pair (A, B) is defined as the absolute difference between A and B.

Example 1:
Input:
nums = [1,3,1]
k = 1
Output: 0 
Explanation:
Here are all the pairs:
(1,3) -> 2
(1,1) -> 0
(3,1) -> 2
Then the 1st smallest distance pair is (1,1), and its distance is 0.
Note:
2 <= len(nums) <= 10000.
0 <= nums[i] < 1000000.
1 <= k <= len(nums) * (len(nums) - 1) / 2.

Hint 1: 
Binary search for the answer. How can you check how many pairs have distance <= X?
*/

/*
Solution 1:

We will use a sliding window approach to count the number of pairs with distance <= guess.

For every possible right, we maintain the loop invariant: left is the smallest value such that nums[right] - nums[left] <= guess. Then, the number of pairs with right as it's right-most endpoint is right - left, and we add all of these up.

Time Complexity: O(n log w + n log n)
- n is nums.count
- w is nums[n-1] - nums[0]
- logW for binary search
- O(n) inside call 

Space Complexity: O(1)
*/
class Solution {
    func smallestDistancePair(_ nums: [Int], _ k: Int) -> Int {
        var nums = nums.sorted()
        
        let n = nums.count
        
        var low = 0
        var high = nums[n-1] - nums[0]
        
        while low < high {
            let mid = low + (high - low)/2
            var count = 0
            var left = 0
            for right in 0..<n {
                while nums[right] - nums[left] > mid {
                    left += 1
                }
                count += right - left
            }
            
            if count >= k {
                high = mid
            } else {
                low = mid+1
            }
        }
        return low
    }
}