/*
You are given a binary string s. You are allowed to perform two types of operations on the string in any sequence:

Type-1: Remove the character at the start of the string s and append it to the end of the string.
Type-2: Pick any character in s and flip its value, i.e., if its value is '0' it becomes '1' and vice-versa.
Return the minimum number of type-2 operations you need to perform such that s becomes alternating.

The string is called alternating if no two adjacent characters are equal.

For example, the strings "010" and "1010" are alternating, while the string "0100" is not.


Example 1:

Input: s = "111000"
Output: 2
Explanation: Use the first operation two times to make s = "100011".
Then, use the second operation on the third and sixth elements to make s = "101010".
Example 2:

Input: s = "010"
Output: 0
Explanation: The string is already alternating.
Example 3:

Input: s = "1110"
Output: 1
Explanation: Use the second operation on the second element to make s = "1010".


Constraints:

1 <= s.length <= 105
s[i] is either '0' or '1'.

*/

/*
Solution 1:
sliding window

Idea
- For the 1st operation, we can simply do s += s to append the whole string to the end.
- then we make two different string with the same length by 01 and 10 alternative. for example: s = 11100
s = 1110011100
s1= 1010101010
s2= 0101010101
- finally, use sliding window（size n）to compare s to both s1 and s2.

Time complexity
Time O(N)
Space O(N)
*/
class Solution {
    func minFlips(_ s: String) -> Int {
        let n = s.count
        var s: [Character] = Array(s)
        s += s

        var s1: [Character] = Array(repeating: "0", count: s.count)
        var s2: [Character] = Array(repeating: "1", count: s.count)
        for i in stride(from: 1, through: s.count-1, by: 2) {
            s1[i] = "1"
            s2[i] = "0"
        }

        // print(s1, s2)

        var res1 = 0
        var res2 = 0
        var res = Int.max

        for i in 0..<s.count {
            if s[i] != s1[i] { res1 += 1 }
            if s[i] != s2[i] { res2 += 1 }

            // always keep window as n length
            // flip operations required in s1[i-n ... i], s2[i-2...i]
            if i >= n {
                // operation 1 check
                if s[i-n] != s1[i-n] { res1 -= 1 }
                if s[i-n] != s2[i-n] { res2 -= 1 }
            }

            if i >= n-1 {
                res = min(res, min(res1, res2))
            }
        }
        return res
    }
}