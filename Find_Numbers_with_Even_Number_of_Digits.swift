/*
Given an array nums of integers, return how many of them contain an even number of digits.
 

Example 1:

Input: nums = [12,345,2,6,7896]
Output: 2
Explanation: 
12 contains 2 digits (even number of digits). 
345 contains 3 digits (odd number of digits). 
2 contains 1 digit (odd number of digits). 
6 contains 1 digit (odd number of digits). 
7896 contains 4 digits (even number of digits). 
Therefore only 12 and 7896 contain an even number of digits.
Example 2:

Input: nums = [555,901,482,1771]
Output: 1 
Explanation: 
Only 1771 contains an even number of digits.
 

Constraints:

1 <= nums.length <= 500
1 <= nums[i] <= 10^5

Hint 1:
How to compute the number of digits of a number ?

Hint 2:
Divide the number by 10 again and again to get the number of digits.
*/

/*
Solution 2:
use String(num).count to get digit

Time Complexity: O(nk), n is nums.count. k is max of nums[i].digit count
Space Complexity: O(1)
*/

class Solution {
    func findNumbers(_ nums: [Int]) -> Int {
        return nums.reduce(into: 0) { res, next in
            if String(next).count % 2 == 0 {
                res += 1
            }
        }
    }
}

/*
Solution 1:
count digit by num/10

Time Complexity: O(nk), n is nums.count. k is max of nums[i].digit count
Space Complexity: O(1)
*/
class Solution {
    func findNumbers(_ nums: [Int]) -> Int {
        return nums.reduce(into: 0) { res, next in
            if getDigit(next) % 2 == 0 {
                res += 1
            }
        }
    }
    
    func getDigit(_ num: Int) -> Int {
        var num = num
        var res = 0
        while num != 0 {
            res += 1
            num /= 10
        }
        return res
    }
}