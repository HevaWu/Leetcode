/*
Given an integer columnNumber, return its corresponding column title as it appears in an Excel sheet.

For example:

A -> 1
B -> 2
C -> 3
...
Z -> 26
AA -> 27
AB -> 28
...


Example 1:

Input: columnNumber = 1
Output: "A"
Example 2:

Input: columnNumber = 28
Output: "AB"
Example 3:

Input: columnNumber = 701
Output: "ZY"


Constraints:

1 <= columnNumber <= 231 - 1
*/

/*
Solution 1
recursive check number

Time Complexity: O(log_26^columnNumber)
Space Complexity: O(1)
*/
class Solution {
    func convertToTitle(_ columnNumber: Int) -> String {
        if columnNumber == 0 {
            return ""
        } else {
            var num = columnNumber - 1
            let charA = Character("A").asciiValue!
            let index = Int(charA) + num % 26
            return convertToTitle(num/26) + String(Character(UnicodeScalar(index)!))
        }
    }
}
