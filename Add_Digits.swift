/*
Given an integer num, repeatedly add all its digits until the result has only one digit, and return it.



Example 1:

Input: num = 38
Output: 2
Explanation: The process is
38 --> 3 + 8 --> 11
11 --> 1 + 1 --> 2
Since 2 has only one digit, return it.
Example 2:

Input: num = 0
Output: 0


Constraints:

0 <= num <= 231 - 1


Follow up: Could you do it without any loop/recursion in O(1) runtime?
*/

/*
Solution 2:
digital root

Time Complexity: O(1)
Space Complexity: O(1)
*/
class Solution {
    func addDigits(_ num: Int) -> Int {
        if num == 0 { return 0}
        if num % 9 == 0 { return 9 }
        return num % 9
    }
}

/*
Solution 1:
while loop to check all digit

Time Complexity: O(n!)
- n is original number's digit count
Space Complexity: O(1)
*/
class Solution {
    func addDigits(_ num: Int) -> Int {
        var num = num
        while num >= 10 {
            // add num's digit
            var sum = 0
            while num > 0 {
                sum += num % 10
                num /= 10
            }
            num = sum
        }
        return num
    }
}
