/*
Given a positive integer num, write a function which returns True if num is a perfect square else False.

Follow up: Do not use any built-in library function such as sqrt.

 

Example 1:

Input: num = 16
Output: true
Example 2:

Input: num = 14
Output: false
 

Constraints:

1 <= num <= 2^31 - 1
*/

/*
Solution 1:
Binary search

use start <= end
start = mid+1
end = mid-1

Time Complexity: O(logn)
Space Complexity: O(1)
*/
class Solution {
    func isPerfectSquare(_ num: Int) -> Bool {
        if num == 1 { return true }
        
        var start = 0
        var end = num/2
        while start <= end {
            let mid = start + (end-start)/2
            let val = mid*mid
            if val == num {
                return true
            } else if val < num {
                start = mid+1
            } else {
                end = mid-1
            }
        }
        return false
    }
}
