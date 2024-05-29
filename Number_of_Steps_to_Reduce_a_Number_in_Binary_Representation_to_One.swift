/*
Given the binary representation of an integer as a string s, return the number of steps to reduce it to 1 under the following rules:

If the current number is even, you have to divide it by 2.

If the current number is odd, you have to add 1 to it.

It is guaranteed that you can always reach one for all test cases.



Example 1:

Input: s = "1101"
Output: 6
Explanation: "1101" corressponds to number 13 in their decimal representation.
Step 1) 13 is odd, add 1 and obtain 14.
Step 2) 14 is even, divide by 2 and obtain 7.
Step 3) 7 is odd, add 1 and obtain 8.
Step 4) 8 is even, divide by 2 and obtain 4.
Step 5) 4 is even, divide by 2 and obtain 2.
Step 6) 2 is even, divide by 2 and obtain 1.
Example 2:

Input: s = "10"
Output: 1
Explanation: "10" corressponds to number 2 in their decimal representation.
Step 1) 2 is even, divide by 2 and obtain 1.
Example 3:

Input: s = "1"
Output: 0


Constraints:

1 <= s.length <= 500
s consists of characters '0' or '1'
s[0] == '1'
*/

/*
Solution 1:
Reverse the string, then map iterate array and follow the step adding logic

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func numSteps(_ s: String) -> Int {
        var s = Array(s)
        s.reverse() // reverse, so can check array from left to right
        var step = 0
        var i = 0
        while (i+1) < s.count {
            // print(s[i])
            if s[i] == Character("0") {
                // even
                i += 1
            } else {
                // old, add 1
                var j = i
                while j < s.count, s[j] == Character("1") {
                    s[j] = Character("0")
                    j += 1
                }
                if j == s.count {
                    s.append(Character("1"))
                } else {
                    s[j] = Character("1")
                }
            }
            step += 1
        }
        return step
    }
}
