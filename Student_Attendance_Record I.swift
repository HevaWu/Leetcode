/*
You are given a string s representing an attendance record for a student where each character signifies whether the student was absent, late, or present on that day. The record only contains the following three characters:

'A': Absent.
'L': Late.
'P': Present.
The student is eligible for an attendance award if they meet both of the following criteria:

The student was absent ('A') for strictly fewer than 2 days total.
The student was never late ('L') for 3 or more consecutive days.
Return true if the student is eligible for an attendance award, or false otherwise.



Example 1:

Input: s = "PPALLP"
Output: true
Explanation: The student has fewer than 2 absences and was never late 3 or more consecutive days.
Example 2:

Input: s = "PPALLL"
Output: false
Explanation: The student was late 3 consecutive days in the last 3 days, so is not eligible for the award.


Constraints:

1 <= s.length <= 1000
s[i] is either 'A', 'L', or 'P'.
*/

/*
Solution 1:
A for checking absent days
L for checking consecutive late days

if A >= 2 or L >= 3, return false
otherwise, return true

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func checkRecord(_ s: String) -> Bool {
        let n = s.count

        var s = Array(s)
        var A = 0
        // consecutive late
        var L = 0
        for i in 0..<n {
            if s[i] == "A" {
                A += 1
                if A >= 2 { return false }
            } else if s[i] == "L" {
                if i > 0, s[i-1] == "L" {
                    L += 1
                    if L >= 3 { return false }
                } else {
                    // no consecutive L for now, set it to 1
                    L = 1
                }
            }
        }

        return true
    }
}