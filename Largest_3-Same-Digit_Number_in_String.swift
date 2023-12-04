/*
You are given a string num representing a large integer. An integer is good if it meets the following conditions:

It is a substring of num with length 3.
It consists of only one unique digit.
Return the maximum good integer as a string or an empty string "" if no such integer exists.

Note:

A substring is a contiguous sequence of characters within a string.
There may be leading zeroes in num or a good integer.


Example 1:

Input: num = "6777133339"
Output: "777"
Explanation: There are two distinct good integers: "777" and "333".
"777" is the largest, so we return "777".
Example 2:

Input: num = "2300019"
Output: "000"
Explanation: "000" is the only good integer.
Example 3:

Input: num = "42352338"
Output: ""
Explanation: No substring of length 3 consists of only one unique digit. Therefore, there are no good integers.


Constraints:

3 <= num.length <= 1000
num only consists of digits.
*/

/*
Solution 1:
Go through string, find largest good string digit and its char
Form the good string from char

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func largestGoodInteger(_ num: String) -> String {
        var num = Array(num)
        let n = num.count
        var digit = -1
        var c: String = "*"
        for i in 0..<(n-2) {
            if num[i] == num[i+1], num[i] == num[i+2] {
                let tmp = num[i].wholeNumberValue ?? -1
                if tmp > digit {
                    digit = tmp
                    c = String(num[i])
                }
            }
        }
        if digit == -1 { return "" }
        return [c, c, c].joined(separator: "")
    }
}
