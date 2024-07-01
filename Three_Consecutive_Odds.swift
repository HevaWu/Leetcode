/*
Given an integer array arr, return true if there are three consecutive odd numbers in the array. Otherwise, return false.


Example 1:

Input: arr = [2,6,4,1]
Output: false
Explanation: There are no three consecutive odds.
Example 2:

Input: arr = [1,2,34,3,4,5,7,23,12]
Output: true
Explanation: [5,7,23] are three consecutive odds.


Constraints:

1 <= arr.length <= 1000
1 <= arr[i] <= 1000
*/

/*
Solution 1:
Iterate array and keep counting odd number

Time Complexity: O(1)
Space Complexity: O(1)
*/
class Solution {
    func threeConsecutiveOdds(_ arr: [Int]) -> Bool {
        var oddCount = 0
        for num in arr {
            if num % 2 == 1 {
                oddCount += 1
            } else {
                oddCount = 0
            }
            if oddCount == 3 {
                return true
            }
        }
        return false
    }
}
