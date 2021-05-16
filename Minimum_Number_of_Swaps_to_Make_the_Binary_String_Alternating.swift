/*
Given a binary string s, return the minimum number of character swaps to make it alternating, or -1 if it is impossible.

The string is called alternating if no two adjacent characters are equal. For example, the strings "010" and "1010" are alternating, while the string "0100" is not.

Any two characters may be swapped, even if they are not adjacent.



Example 1:

Input: s = "111000"
Output: 1
Explanation: Swap positions 1 and 4: "111000" -> "101010"
The string is now alternating.
Example 2:

Input: s = "010"
Output: 0
Explanation: The string is already alternating, no swaps are needed.
Example 3:

Input: s = "1110"
Output: -1


Constraints:

1 <= s.length <= 1000
s[i] is either '0' or '1'.
*/

/*
Solution 1:

- check if one, zero diff is <= 1, if not, return -1
- record need to be replaced count for "0" and "1"
    - If number of ones is greater than number of zeroes then 1 should be the first character of resulting string. Similarly if number of zeroes is greater than number of ones then 0 should be the first character of resulting string.
    - If number of ones is equal to number of zeroes, we will find minimum number of swaps of both cases:
        - Case 1 : 1 is the first character.
        - Case 2 : 0 is the first character.

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func minSwaps(_ s: String) -> Int {
        var s = Array(s)
        let n = s.count

        var zero = 0
        var one = 0
        for i in 0..<n {
            if s[i] == "0" {
                zero += 1
            } else {
                one += 1
            }
        }

        // swap step if put `char` as first element
        func needSwap(_ char: Character) -> Int {
            var char = char
            var swap = 0
            for c in s {
                if c != char { swap += 1 }
                char = char == "1" ? "0" : "1"
            }
            //  /2 at here, just swap character at index 0 and index 1 to obtain s = 10101.
            return swap/2
        }

        let diff = abs(zero-one)
        if diff > 1 { return -1 }

        let swapZero = needSwap("0")
        let swapOne = needSwap("1")
        if one > zero {
            return swapOne
        } else if one < zero {
            return swapZero
        }
        return min(swapOne, swapZero)
    }
}