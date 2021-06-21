/*
A string is called happy if it does not have any of the strings 'aaa', 'bbb' or 'ccc' as a substring.

Given three integers a, b and c, return any string s, which satisfies following conditions:

s is happy and longest possible.
s contains at most a occurrences of the letter 'a', at most b occurrences of the letter 'b' and at most c occurrences of the letter 'c'.
s will only contain 'a', 'b' and 'c' letters.
If there is no such string s return the empty string "".



Example 1:

Input: a = 1, b = 1, c = 7
Output: "ccaccbcc"
Explanation: "ccbccacc" would also be a correct answer.
Example 2:

Input: a = 2, b = 2, c = 1
Output: "aabbc"
Example 3:

Input: a = 7, b = 1, c = 0
Output: "aabaa"
Explanation: It's the only correct answer in this case.


Constraints:

0 <= a, b, c <= 100
a + b + c > 0
*/

/*
Solution 1:
greedy

always keep a >= b >= c
always try to add "aa",
if a-2 >= b, add one "b", if not, next turn add "bb"
repeat, recursively generate string

greedy use a, b to generate

Time Complexity: O(a+b+c)
Space Complexity: O(1)
*/
class Solution {
    func longestDiverseString(_ a: Int, _ b: Int, _ c: Int) -> String {
        return generate(a, b, c, Character("a"), Character("b"), Character("c"))
    }

    // keep a > b > c
    func generate(_ a: Int, _ b: Int, _ c: Int,
                  _ charA: Character, _ charB: Character, _ charC: Character) -> String {
        if a < b { return generate(b, a, c, charB, charA, charC) }
        if b < c { return generate(a, c, b, charA, charC, charB) }
        if b == 0 {
            return String(repeating: charA, count: min(2, a))
        }

        let countA = min(2, a)
        // If a - 2 >= b, add 'b'
        // (if not, the next round will add 'bb')
        let countB = a-countA >= b ? 1 : 0
        return String(repeating: charA, count: countA) + String(repeating: charB, count: countB) + generate(a-countA, b-countB, c, charA, charB, charC)
    }
}