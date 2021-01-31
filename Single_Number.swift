/*
Given a non-empty array of integers nums, every element appears twice except for one. Find that single one.

Follow up: Could you implement a solution with a linear runtime complexity and without using extra memory?

 

Example 1:

Input: nums = [2,2,1]
Output: 1
Example 2:

Input: nums = [4,1,2,1,2]
Output: 4
Example 3:

Input: nums = [1]
Output: 1
 

Constraints:

1 <= nums.length <= 3 * 104
-3 * 104 <= nums[i] <= 3 * 104
Each element in the array appears twice except for one element which appears only once.
*/

/*
Solution 3:
Bit manipulation

take XOR to each num
- a ^ 0 = res
- a ^ a = 0
=> a ^ b ^ a = b

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func singleNumber(_ nums: [Int]) -> Int {
        var res = 0
        
        for n in nums {
            res ^= n
        }
        return res
    }
}

/*
Solution 2:
Math

2∗(a+b+c)−(a+a+b+b+c)=c
*/


/*
Solution 1:
set

each element will only appear 1 or 2 times
if element appears before, remove it from set
if element not appears before, insert it 

according to the description,
at the end, we should only have one elemnt in the st 

Time Complexity: O(n)
Space Complexity: O(n/2) where n is nums.count
*/
class Solution {
    func singleNumber(_ nums: [Int]) -> Int {
        var set = Set<Int>()
        for n in nums {
            if set.contains(n) {
                set.remove(n)
            } else {
                set.insert(n)
            }
        }
        return set.first ?? 0
    }
}