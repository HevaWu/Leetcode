/*
Given a string s of zeros and ones, return the maximum score after splitting the string into two non-empty substrings (i.e. left substring and right substring).

The score after splitting a string is the number of zeros in the left substring plus the number of ones in the right substring.



Example 1:

Input: s = "011101"
Output: 5
Explanation:
All possible ways of splitting s into two non-empty substrings are:
left = "0" and right = "11101", score = 1 + 4 = 5
left = "01" and right = "1101", score = 1 + 3 = 4
left = "011" and right = "101", score = 1 + 2 = 3
left = "0111" and right = "01", score = 1 + 1 = 2
left = "01110" and right = "1", score = 2 + 1 = 3
Example 2:

Input: s = "00111"
Output: 5
Explanation: When left = "00" and right = "111", we get the maximum score = 2 + 3 = 5
Example 3:

Input: s = "1111"
Output: 3


Constraints:

2 <= s.length <= 500
The string s consists of characters '0' and '1' only.
*/

/*
Solution 2:
Count totalOne in advance

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func maxScore(_ s: String) -> Int {
        var totalOne = 0
        var s = Array(s)
        let n = s.count
        for c in s {
            if c == Character("1") {
                totalOne += 1
            }
        }

        var score = 0
        var curZero = 0
        var curOne = 0
        // Use n-1 make sure it has right substring
        for i in 0..<(n-1) {
            if s[i] == Character("0") {
                curZero += 1
            } else {
                curOne += 1
            }
            let rightOne = totalOne - curOne
            score = max(score, curZero + rightOne)
            // print(i, score, curZero, totalZero)
        }
        return score
    }
}

/*
Solution 1:
use totalZero to count all zero before

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func maxScore(_ s: String) -> Int {
        var totalZero = 0
        var s = Array(s)
        let n = s.count
        for c in s {
            if c == Character("0") {
                totalZero += 1
            }
        }

        var score = 0
        var curZero = 0
        // Use n-1 make sure it has right substring
        for i in 0..<(n-1) {
            if s[i] == Character("0") {
                curZero += 1
            }
            let remainEle = n-(i+1)
            let remainZero = totalZero - curZero
            let rightOne = remainEle - remainZero
            score = max(score, curZero + rightOne)
            // print(i, score, curZero, totalZero)
        }
        return score
    }
}
