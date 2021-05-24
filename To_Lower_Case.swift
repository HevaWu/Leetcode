/*
Given a string s, return the string after replacing every uppercase letter with the same lowercase letter.



Example 1:

Input: s = "Hello"
Output: "hello"
Example 2:

Input: s = "here"
Output: "here"
Example 3:

Input: s = "LOVELY"
Output: "lovely"


Constraints:

1 <= s.length <= 100
s consists of printable ASCII characters.
*/

/*
Solution 2:
convert char to int then to char
*/
class Solution {
    func toLowerCase(_ s: String) -> String {
        let ascii_a = Character("a").asciiValue!
        let ascii_A = Character("A").asciiValue!

        var s: [Character] = Array(s)
        for i in s.indices {
            let c = s[i]

            if c.isUppercase {
                // Note: Character(UnicodeScalar(Int)!)
                s[i] = Character(UnicodeScalar(Int(ascii_a + c.asciiValue! - ascii_A))!)
            }
        }
        return String(s)
    }
}

/*
Solution 1:
default swift method
*/
class Solution {
    func toLowerCase(_ s: String) -> String {
        return s.lowercased()
    }
}