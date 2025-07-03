/*
Alice and Bob are playing a game. Initially, Alice has a string word = "a".

You are given a positive integer k.

Now Bob will ask Alice to perform the following operation forever:

Generate a new string by changing each character in word to its next character in the English alphabet, and append it to the original word.
For example, performing the operation on "c" generates "cd" and performing the operation on "zb" generates "zbac".

Return the value of the kth character in word, after enough operations have been done for word to have at least k characters.

Note that the character 'z' can be changed to 'a' in the operation.



Example 1:

Input: k = 5

Output: "b"

Explanation:

Initially, word = "a". We need to do the operation three times:

Generated string is "b", word becomes "ab".
Generated string is "bc", word becomes "abbc".
Generated string is "bccd", word becomes "abbcbccd".
Example 2:

Input: k = 10

Output: "c"



Constraints:

1 <= k <= 500
*/

/*
Solution 1:
use int array to record current character array
Time Complexity: O(k^2)
Space Complexity: O(k)
*/

class Solution {
    func kthCharacter(_ k: Int) -> Character {
        var cur = [Int]()
        cur = [0]
        while cur.count <= k {
            for num in cur {
                if (num+1==26) {
                    cur.append(0)
                } else {
                    cur.append(num+1)
                }
            }
        }
        let index = cur[k-1]
        let a = Int(Character("a").asciiValue!)
        return Character(UnicodeScalar(index + a)!)
    }
}
