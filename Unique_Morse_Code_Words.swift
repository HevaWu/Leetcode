/*
International Morse Code defines a standard encoding where each letter is mapped to a series of dots and dashes, as follows:

'a' maps to ".-",
'b' maps to "-...",
'c' maps to "-.-.", and so on.
For convenience, the full table for the 26 letters of the English alphabet is given below:

[".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."]
Given an array of strings words where each word can be written as a concatenation of the Morse code of each letter.

For example, "cab" can be written as "-.-..--...", which is the concatenation of "-.-.", ".-", and "-...". We will call such a concatenation the transformation of a word.
Return the number of different transformations among all words we have.



Example 1:

Input: words = ["gin","zen","gig","msg"]
Output: 2
Explanation: The transformation of each word is:
"gin" -> "--...-."
"zen" -> "--...-."
"gig" -> "--...--."
"msg" -> "--...--."
There are 2 different transformations: "--...-." and "--...--.".
Example 2:

Input: words = ["a"]
Output: 1


Constraints:

1 <= words.length <= 100
1 <= words[i].length <= 12
words[i] consists of lowercase English letters.
*/

/*
Solution 1:
Set

use morse: [String] to help mapping character to morse code
for each word, get its transformation, and put them in a set
return number of string in the set is the answer

Time Complexity: O(nm)
- n = words.count
- m = words[i].count
Space Complexity: O(nm)
*/
class Solution {
    func uniqueMorseRepresentations(_ words: [String]) -> Int {
        let n = words.count
        if n == 1 { return 1 }

        let morse = [".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."]

        let asciia = Character("a").asciiValue!
        var transformation = Set<String>()

        for word in words {
            var t = ""
            for c in word {
                t += morse[Int(c.asciiValue! - asciia)]
            }
            transformation.insert(t)
        }

        return transformation.count
    }
}