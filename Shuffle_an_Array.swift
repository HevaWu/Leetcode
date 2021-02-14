/*
Given an integer array nums, design an algorithm to randomly shuffle the array.

Implement the Solution class:

Solution(int[] nums) Initializes the object with the integer array nums.
int[] reset() Resets the array to its original configuration and returns it.
int[] shuffle() Returns a random shuffling of the array.
 

Example 1:

Input
["Solution", "shuffle", "reset", "shuffle"]
[[[1, 2, 3]], [], [], []]
Output
[null, [3, 1, 2], [1, 2, 3], [1, 3, 2]]

Explanation
Solution solution = new Solution([1, 2, 3]);
solution.shuffle();    // Shuffle the array [1,2,3] and return its result. Any permutation of [1,2,3] must be equally likely to be returned. Example: return [3, 1, 2]
solution.reset();      // Resets the array back to its original configuration [1,2,3]. Return [1, 2, 3]
solution.shuffle();    // Returns the random shuffling of array [1,2,3]. Example: return [1, 3, 2]

 

Constraints:

1 <= nums.length <= 200
-106 <= nums[i] <= 106
All the elements of nums are unique.
At most 5 * 104 calls will be made to reset and shuffle.
*/

/*
Solution 2
Fisher-Yates algorithm

cut down the time and space complexities of shuffle with a bit of cleverness - namely, by swapping elements around within the array itself, we can avoid the linear space cost of the auxiliary array and the linear time cost of list modification.
*/
class Solution {
    var original: [Int]

    init(_ nums: [Int]) {
        self.original = nums
    }
    
    /** Resets the array to its original configuration and return it. */
    func reset() -> [Int] {
        return original
    }
    
    /** Returns a random shuffling of the array. */
    func shuffle() -> [Int] {
        let n = original.count
        var res = original
        for i in 0..<n {
            res.swapAt(i, Int.random(in: i..<n))
        }
        return res
    }
}

/**
 * Your Solution object will be instantiated and called as such:
 * let obj = Solution(nums)
 * let ret_1: [Int] = obj.reset()
 * let ret_2: [Int] = obj.shuffle()
 */

/*
Solution 1
use swift default array function

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    var original: [Int]

    init(_ nums: [Int]) {
        self.original = nums
    }
    
    /** Resets the array to its original configuration and return it. */
    func reset() -> [Int] {
        return original
    }
    
    /** Returns a random shuffling of the array. */
    func shuffle() -> [Int] {
        return original.shuffled()
    }
}

/**
 * Your Solution object will be instantiated and called as such:
 * let obj = Solution(nums)
 * let ret_1: [Int] = obj.reset()
 * let ret_2: [Int] = obj.shuffle()
 */