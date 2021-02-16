/*
Given an array nums containing n distinct numbers in the range [0, n], return the only number in the range that is missing from the array.

Follow up: Could you implement a solution using only O(1) extra space complexity and O(n) runtime complexity?

 

Example 1:

Input: nums = [3,0,1]
Output: 2
Explanation: n = 3 since there are 3 numbers, so all numbers are in the range [0,3]. 2 is the missing number in the range since it does not appear in nums.
Example 2:

Input: nums = [0,1]
Output: 2
Explanation: n = 2 since there are 2 numbers, so all numbers are in the range [0,2]. 2 is the missing number in the range since it does not appear in nums.
Example 3:

Input: nums = [9,6,4,2,3,5,7,0,1]
Output: 8
Explanation: n = 9 since there are 9 numbers, so all numbers are in the range [0,9]. 8 is the missing number in the range since it does not appear in nums.
Example 4:

Input: nums = [0]
Output: 1
Explanation: n = 1 since there is 1 number, so all numbers are in the range [0,1]. 1 is the missing number in the range since it does not appear in nums.
 

Constraints:

n == nums.length
1 <= n <= 104
0 <= nums[i] <= n
All the numbers of nums are unique.
*/

/*
Solution 4
math
gauss' formula

nSum of 1 to n should be n*(n+1)/2
calculate sum of nums

return nSum-sum
*/
class Solution {
    func missingNumber(_ nums: [Int]) -> Int {
        var nSum = (nums.count*(nums.count + 1)) / 2
        var sum = 0
        for num in nums {
            sum += num
        }
        return nSum - sum
    }
}


/*
Solution 3
use bit XOR

for index 0 1 2 3
for value 0 1 3 4

missing
=4∧(0∧0)∧(1∧1)∧(2∧3)∧(3∧4)
=(4∧4)∧(0∧0)∧(1∧1)∧(3∧3)∧2
=0∧0∧0∧0∧2
=2
​	
Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func missingNumber(_ nums: [Int]) -> Int {
        var miss = nums.count
        for i in 0..<nums.count {
            miss ^= (i ^ nums[i])
        }
        return miss
    }
}

/*
Solution 2
optimize soluton 1
use only one param
*/
class Solution {
    func missingNumber(_ nums: [Int]) -> Int {
        var sum = 0
        for i in 0..<nums.count {
            sum += (i + 1 - nums[i])
        }
        return sum
    }
}

/*
Solution 1
count nSum of 1+2+...+n
and sum of nums
return nSum-sum as result

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func missingNumber(_ nums: [Int]) -> Int {
        var sum = 0
        var nSum = 0
        for i in 0..<nums.count {
            sum += nums[i]
            nSum += (i+1)
        }
        return nSum-sum
    }
}