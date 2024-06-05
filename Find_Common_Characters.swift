/*
Given an array words of strings made only from lowercase letters, return a list of all characters that show up in all strings within the list (including duplicates).  For example, if a character occurs 3 times in all strings but not 4 times, you need to include that character three times in the final answer.

You may return the answer in any order.



Example 1:

Input: ["bella","label","roller"]
Output: ["e","l","l"]
Example 2:

Input: ["cool","lock","cook"]
Output: ["c","o"]


Note:

1 <= words.length <= 100
1 <= words[i].length <= 100
words[i] consists of lowercase English letters.

*/

/*
Solution 2:
keep record the lowercase character frequency in charArr
for each word, compare the charArr and current word char frequency

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func commonChars(_ words: [String]) -> [String] {
        let a = Character("a").asciiValue!
        // record the frequency of lowercase char array of common characters
        var charArr = Array(repeating: 0, count: 26)
        let n = words.count
        for i in 0..<n {
            var cur = Array(repeating: 0, count: 26)
            for c in words[i] {
                let index = Int(c.asciiValue! - a)
                cur[index] += 1
            }

            if i > 0 {
                for j in 0..<26 {
                    charArr[j] = min(charArr[j], cur[j])
                }
            } else {
                charArr = cur
            }
        }

        var res = [String]()
        for i in 0..<26 {
            if charArr[i] > 0 {
                let str = String(UnicodeScalar(Int(a)+i)!)
                res.append(contentsOf: Array(repeating: str, count: charArr[i]))
            }
        }
        return res
    }
}

/*
Solution 1:
map

build charMap for each word,
iteratively compare current word charMap with common charMap

in the end, convert charmap to build res string lists

Time Complexity: O(mn)
- n words.count
- m largest words[i].count

Space Complexity: O(m)
*/
class Solution {
    func commonChars(_ words: [String]) -> [String] {
        var charMap = getMap(words[0])
        for i in 1..<words.count {
            let wordMap = getMap(words[i])

            // compare charMap with wordMap
            for (k, v) in charMap {
                let common = min(v, wordMap[k, default: 0])
                if common == 0 {
                    // remove k from charMap
                    charMap[k] = nil
                } else {
                    charMap[k] = common
                }
            }
        }

        // generate res by charMap
        var res = [String]()
        for (k, v) in charMap {
            res.append(contentsOf: Array(repeating: String(k), count: v))
        }
        return res
    }

    func getMap(_ word: String) -> [Character: Int] {
        var map = [Character: Int]()
        for c in word {
            map[c, default: 0] += 1
        }
        return map
    }
}
