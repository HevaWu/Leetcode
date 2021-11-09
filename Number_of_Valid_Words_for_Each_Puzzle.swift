/*
With respect to a given puzzle string, a word is valid if both the following conditions are satisfied:
word contains the first letter of puzzle.
For each letter in word, that letter is in puzzle.
For example, if the puzzle is "abcdefg", then valid words are "faced", "cabbage", and "baggage", while
invalid words are "beefed" (does not include 'a') and "based" (includes 's' which is not in the puzzle).
Return an array answer, where answer[i] is the number of words in the given word list words that is valid with respect to the puzzle puzzles[i].


Example 1:

Input: words = ["aaaa","asas","able","ability","actt","actor","access"], puzzles = ["aboveyz","abrodyz","abslute","absoryz","actresz","gaswxyz"]
Output: [1,1,3,2,4,0]
Explanation:
1 valid word for "aboveyz" : "aaaa"
1 valid word for "abrodyz" : "aaaa"
3 valid words for "abslute" : "aaaa", "asas", "able"
2 valid words for "absoryz" : "aaaa", "asas"
4 valid words for "actresz" : "aaaa", "asas", "actt", "access"
There are no valid words for "gaswxyz" cause none of the words in the list contains letter 'g'.
Example 2:

Input: words = ["apple","pleas","please"], puzzles = ["aelwxyz","aelpxyz","aelpsxy","saelpxy","xaelpsy"]
Output: [0,1,3,2,0]


Constraints:

1 <= words.length <= 105
4 <= words[i].length <= 50
1 <= puzzles.length <= 104
puzzles[i].length == 7
words[i] and puzzles[i] consist of lowercase English letters.
Each puzzles[i] does not contain repeated characters.
*/

/*
Solution 3:
Trie + DFS

Step 1: Build the trie.

For each word in words:
Sort the word and remove duplicate letters.
Store the word, which is now a sorted list of distinct characters, in the trie.

Step 2: Count the number of valid words for each puzzle.

For each puzzle in puzzles:
Iterate over the trie to find all valid words for the current puzzle.

*/

/*
Solution 2:
Bitmask with map

Step 1: Build the map.

For each word in words:
Transform it into a bitmask of its characters.
If the bitmask has not been seen before, store it as a key in the map with a value of one.
If it has been seen before, then increment the map's count for this bitmask by one.

Step 2: Count the number of valid words for each puzzle.

For each puzzle in puzzles:
Transform it into a bitmask of its characters.
Iterate over every possible submask containing the first letter in puzzle (puzzle[i][0]). A word is valid for a puzzle if its bitmask matches one of the puzzle's submasks.
For each submask, increase the count by the number of words that match the submask.
We can find the number of words that match the submask using the map built in the previous step.

Time Complexity: O(nw * 50 + np * 2^7)
Space Complexity: O(nw)
*/
class Solution {
    func findNumOfValidWords(_ words: [String], _ puzzles: [String]) -> [Int] {
        let nw = words.count
        let np = puzzles.count

        var map = [Int: Int]()
        for i in 0..<nw {
            let bit_word = getBitmask(words[i])
            map[bit_word, default: 0] += 1
        }

        var valid = Array(repeating: 0, count: np)
        var bit_p = Array(repeating: 0, count: np)
        for i in 0..<np {
            // get words only contains puzzle[0] char
            let first = 1 << Int(puzzles[i].first!.asciiValue! - ascii_a)
            valid[i] = map[first, default: 0]

            // find all combination of substring [1...]
            // check if word map contains it or not
            var substr = puzzles[i]
            substr.removeFirst()
            let mask = getBitmask(substr)

            var submask = mask
            while submask > 0 {
                // | first to add first character
                valid[i] += map[submask | first, default: 0]
                submask = (submask - 1) & mask
            }
        }

        return valid
    }

    let ascii_a = Character("a").asciiValue!
    func getBitmask(_ str: String) -> Int {
        var val = 0
        for c in str {
            val |= 1 << Int(c.asciiValue! - ascii_a)
        }
        return val
    }
}

/*
Solution 1:
Bitmask
Time Limit Exceeded

Time Complexity: O(np * 7 + nw * (largest length of words + np))
Space Complexity: O(np)
*/
class Solution {
    func findNumOfValidWords(_ words: [String], _ puzzles: [String]) -> [Int] {
        let nw = words.count
        let np = puzzles.count

        var bit_p = Array(repeating: 0, count: np)
        var valid = Array(repeating: 0, count: np)

        for i in 0..<np {
            bit_p[i] = getBitmask(puzzles[i])
        }

        // print(bit_p)
        for i in 0..<nw {
            let bit_word = getBitmask(words[i])

            for j in 0..<np {
                var isMatched = true

                // 1. word contains first letter of puzzle
                if bit_word & (1 << Int(puzzles[j].first!.asciiValue! - ascii_a)) == 0 {
                    isMatched = false
                }

                // 2. each letter in word appear in puzzle
                if bit_word & bit_p[j] != bit_word {
                    isMatched = false
                }

                if isMatched {
                    valid[j] += 1
                }
            }
        }

        return valid
    }

    let ascii_a = Character("a").asciiValue!
    func getBitmask(_ str: String) -> Int {
        var val = 0
        for c in str {
            val |= 1 << Int(c.asciiValue! - ascii_a)
        }
        return val
    }
}