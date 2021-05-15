/*
A valid number can be split up into these components (in order):

A decimal number or an integer.
(Optional) An 'e' or 'E', followed by an integer.
A decimal number can be split up into these components (in order):

(Optional) A sign character (either '+' or '-').
One of the following formats:
At least one digit, followed by a dot '.'.
At least one digit, followed by a dot '.', followed by at least one digit.
A dot '.', followed by at least one digit.
An integer can be split up into these components (in order):

(Optional) A sign character (either '+' or '-').
At least one digit.
For example, all the following are valid numbers: ["2", "0089", "-0.1", "+3.14", "4.", "-.9", "2e10", "-90E3", "3e+7", "+6e-1", "53.5e93", "-123.456e789"], while the following are not valid numbers: ["abc", "1a", "1e", "e3", "99e2.5", "--6", "-+3", "95a54e53"].

Given a string s, return true if s is a valid number.



Example 1:

Input: s = "0"
Output: true
Example 2:

Input: s = "e"
Output: false
Example 3:

Input: s = "."
Output: false
Example 4:

Input: s = ".1"
Output: true


Constraints:

1 <= s.length <= 20
s consists of only English letters (both uppercase and lowercase), digits (0-9), plus '+', minus '-', or dot '.'.
*/

/*
Solution 1:
iterate string

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func isNumber(_ s: String) -> Bool {
        var s = Array(s)
        let n = s.count

        // 1. check if has sign char
        // 2. check is decimal or integer
        // 3. check if there is an 'e' OR 'E' followed by integer

        var index_e = s.firstIndex(of: "e")
        var index_E = s.firstIndex(of: "E")
        if index_e == nil && index_E == nil {
            return isDecimal(s) || isInteger(s)
        } else if index_e != nil && index_E != nil && index_e != index_E {
            // "e" and "E" has different index, there are multiple e/E in s
            return false
        } else {
            // only index_e exist or index_E exist
            let eindex = index_e == nil ? index_E! : index_e!
            if eindex == 0 || eindex == n-1 { return false }
            let first = Array(s[..<eindex])
            let second = Array(s[(eindex+1)...])
            return (isDecimal(first) || isInteger(first)) && isInteger(second)
        }
    }

    func isDecimal(_ str: [Character]) -> Bool {
        let n = str.count
        if n == 1 {
            return str[0].isNumber
        }

        var hasPoint = false
        for i in 0..<n {
            if str[i].isNumber {
                continue
            } else if isSign(str[i]) {
                if i != 0 { return false }
            } else if str[i] == "." {
                if hasPoint { return false }
                // invalid, if "." left and right not have digits
                if (i == 0 || (i-1 >= 0 && !str[i-1].isNumber))
                && (i == n-1 || (i+1 < n && !str[i+1].isNumber)) {
                    return false
                }
                hasPoint = true
            } else {
                return false
            }
        }
        return true
    }

    func isInteger(_ str: [Character]) -> Bool {
        let n = str.count
        if n == 1 {
            return str[0].isNumber
        }

        for i in 0..<n {
            if str[i].isNumber {
                continue
            } else if isSign(str[i]) {
                if i != 0 { return false }
            } else {
                return false
            }
        }
        return true
    }

    func isE(_ char: Character) -> Bool {
        return char == "e" || char == "E"
    }

    func isSign(_ char: Character) -> Bool {
        return char == "-" || char == "+"
    }
}