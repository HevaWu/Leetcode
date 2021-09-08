/*
You are given a string s of lowercase English letters and an integer array shifts of the same length.

Call the shift() of a letter, the next letter in the alphabet, (wrapping around so that 'z' becomes 'a').

For example, shift('a') = 'b', shift('t') = 'u', and shift('z') = 'a'.
Now for each shifts[i] = x, we want to shift the first i + 1 letters of s, x times.

Return the final string after all such shifts to s are applied.



Example 1:

Input: s = "abc", shifts = [3,5,9]
Output: "rpl"
Explanation: We start with "abc".
After shifting the first 1 letters of s by 3, we have "dbc".
After shifting the first 2 letters of s by 5, we have "igc".
After shifting the first 3 letters of s by 9, we have "rpl", the answer.
Example 2:

Input: s = "aaa", shifts = [1,2,3]
Output: "gfd"


Constraints:

1 <= s.length <= 105
s consists of lowercase English letters.
shifts.length == s.length
0 <= shifts[i] <= 109
*/

/*
Solution 1:
generate final string from end to start

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func shiftingLetters(_ s: String, _ shifts: [Int]) -> String {
        let n = s.count
        var s = Array(s)

        var res: [Character] = Array(repeating: Character("*"), count: n)
        var shiftNum = 0
        for i in stride(from: n-1, through: 0, by: -1) {
            shiftNum = (shiftNum + shifts[i]) % 26
            res[i] = shiftLetter(s[i], shiftNum)
        }
        return String(res)
    }

    let asciiA = Int(Character("a").asciiValue!)
    let asciiZ = Int(Character("z").asciiValue!)
    func shiftLetter(_ c: Character, _ num: Int) -> Character {
        var next = Int(c.asciiValue!) + num
        if next > asciiZ {
            next = next - asciiZ - 1 + asciiA
        }
        return Character(UnicodeScalar(next)!)
    }
}