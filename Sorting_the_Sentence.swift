/*
A sentence is a list of words that are separated by a single space with no leading or trailing spaces. Each word consists of lowercase and uppercase English letters.

A sentence can be shuffled by appending the 1-indexed word position to each word then rearranging the words in the sentence.

For example, the sentence "This is a sentence" can be shuffled as "sentence4 a3 is2 This1" or "is2 sentence4 This1 a3".
Given a shuffled sentence s containing no more than 9 words, reconstruct and return the original sentence.



Example 1:

Input: s = "is2 sentence4 This1 a3"
Output: "This is a sentence"
Explanation: Sort the words in s to their original positions "This1 is2 a3 sentence4", then remove the numbers.
Example 2:

Input: s = "Myself2 Me1 I4 and3"
Output: "Me Myself and I"
Explanation: Sort the words in s to their original positions "Me1 Myself2 and3 I4", then remove the numbers.


Constraints:

2 <= s.length <= 200
s consists of lowercase and uppercase English letters, spaces, and digits from 1 to 9.
The number of words in s is between 1 and 9.
The words in s are separated by a single space.
s contains no leading or trailing spaces.

*/

/*
Solution 1:
iterate s

- split s by " "
- for each subString, get its (index, word), then put it into corresponding array position
- joined to result string

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func sortSentence(_ s: String) -> String {
        var arr = s.split(separator: " ")
        let n = arr.count
        var res = Array(repeating: "", count: n)

        for sub in arr {
            let (index, word) = getFrom(String(sub))
            res[index-1] = word
        }

        return res.joined(separator: " ")
    }

    func getFrom(_ str: String) -> (index: Int, word: String) {
        // 1 indexed word position
        let index = str.last?.wholeNumberValue ?? 0
        let word = String(str.dropLast())
        return (index, word)

//         var str = Array(str)
//         var i = str.count-1
//         while i >= 0 {
//             if !str[i].isNumber {
//                 break
//             }
//             i -= 1
//         }

//         let index = Int(String(str[(i+1)...])) ?? 0
//         let word = String(str[0...i])

//         // print(i, index, word)
//         return (index, word)
    }
}