/*
Given an array of integers nums containing n + 1 integers where each integer is in the range [1, n] inclusive.

There is only one repeated number in nums, return this repeated number.

 

Example 1:

Input: nums = [1,3,4,2,2]
Output: 2
Example 2:

Input: nums = [3,1,3,4,2]
Output: 3
Example 3:

Input: nums = [1,1]
Output: 1
Example 4:

Input: nums = [1,1,2]
Output: 1
 

Constraints:

2 <= n <= 3 * 104
nums.length == n + 1
1 <= nums[i] <= n
All the integers in nums appear only once except for precisely one integer which appears two or more times.
 

Follow up:

How can we prove that at least one duplicate number must exist in nums?
Can you solve the problem without modifying the array nums?
Can you solve the problem using only constant, O(1) extra space?
Can you solve the problem with runtime complexity less than O(n2)?
*/

/*
Solution 2:
Floyd's Tortoise and Hare (Cycle Detection)

1. hare = nums[nums[hare]] is twice as fast as tortoise = nums[tortoise]. Since the hare goes fast, it would be the first one who enters the cycle and starts to run around the cycle. At some point, the tortoise enters the cycle as well, and since it's moving slower the hare catches the tortoise up at some intersection point. Now phase 1 is over, and the tortoise has lost.
  2d(tortoise)=d(hare), 2(F+a)=F+nC+a, where nn is some integer.
2. give the tortoise a second chance by slowing down the hare, so that it now moves with the speed of tortoise: tortoise = nums[tortoise], hare = nums[hare]. The tortoise is back at the starting position, and the hare starts from the intersection point. 
  The tortoise started from zero, so its position after FF steps is FF
  The hare started at the intersection point F + a = nCF+a=nC, so its position after F steps is nC + FnC+F, that is the same point as FF.
  So the tortoise and the (slowed down) hare will meet at the entrance of the cycle.

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func findDuplicate(_ nums: [Int]) -> Int {
		// tortoise
        var t = nums[0]

		// hare
        var h = nums[0]
        
        repeat {
            t = nums[t]
            h = nums[nums[h]]
        } while t != h
        
        // find circle entrance
        t = nums[0]
        while t != h {
            t = nums[t]
            h = nums[h]
        }
        
        return h
    }
}

/*
Solution 1:
set

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func findDuplicate(_ nums: [Int]) -> Int {
        var set = Set<Int>()
        for n in nums {
            if set.contains(n) {
                return n
            }
            set.insert(n)
        }
        return -1
    }
}