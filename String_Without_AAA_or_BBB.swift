/*
Given two integers a and b, return any string s such that:

s has length a + b and contains exactly a 'a' letters, and exactly b 'b' letters,
The substring 'aaa' does not occur in s, and
The substring 'bbb' does not occur in s.


Example 1:

Input: a = 1, b = 2
Output: "abb"
Explanation: "abb", "bab" and "bba" are all correct answers.
Example 2:

Input: a = 4, b = 1
Output: "aabaa"


Constraints:

0 <= a, b <= 100
It is guaranteed such an s exists for the given a and b.

*/

/*
Solution 1:
recursive

always pick larger count of character
after picking, if current char still have larger amount, insert one another char to make sure no 3 repeated char
do recursive by larger char again

Time Complexity: O(a+b)
Space Complexity: O(a+b)
*/
class Solution {
    func strWithout3a3b(_ a: Int, _ b: Int) -> String {
        if a > b {
            return check(a, Character("a"), b, Character("b"))
        } else {
            return check(b, Character("b"), a, Character("a"))
        }
    }

    // n1 > n2
    // c1 indicate n1's char
    // c2 indicate n2's char
    func check(_ n1: Int, _ c1: Character, _ n2: Int, _ c2: Character) -> String {
        if n1 == 0, n2 == 0 { return String() }
        if n1 == 0 { return String(repeating: c2, count: n2) }
        if n2 == 0 { return String(repeating: c1, count: n1) }

        let t1 = min(2, n1)
        var str = String(repeating: c1, count: t1)
        if n1-t1 > n2 {
            // to make sure no connect 3 char
            str.append(c2)
            str.append(check(n1-t1, c1, n2-1, c2))
        } else {
            str.append(check(n2, c2, n1-t1, c1))
        }
        return str
    }
}