/*
In an alien language, surprisingly they also use english lowercase letters, but possibly in a different order. The order of the alphabet is some permutation of lowercase letters.

Given a sequence of words written in the alien language, and the order of the alphabet, return true if and only if the given words are sorted lexicographicaly in this alien language.



Example 1:

Input: words = ["hello","leetcode"], order = "hlabcdefgijkmnopqrstuvwxyz"
Output: true
Explanation: As 'h' comes before 'l' in this language, then the sequence is sorted.
Example 2:

Input: words = ["word","world","row"], order = "worldabcefghijkmnpqstuvxyz"
Output: false
Explanation: As 'd' comes after 'l' in this language, then words[0] > words[1], hence the sequence is unsorted.
Example 3:

Input: words = ["apple","app"], order = "abcdefghijklmnopqrstuvwxyz"
Output: false
Explanation: The first three characters "app" match, and the second string is shorter (in size.) According to lexicographical rules "apple" > "app", because 'l' > '∅', where '∅' is defined as the blank character which is less than any other character (More info).


Constraints:

1 <= words.length <= 100
1 <= words[i].length <= 20
order.length == 26
All characters in words[i] and order are English lowercase letters.
*/

/*
Solution 2:
compare adjacency 2 string in words would be enough

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution2 {
    func isAlienSorted(_ words: [String], _ order: String) -> Bool {
        // make order map
        var map = [Character: Int]()
        for (i, c) in order.enumerated() {
            map[c] = i
        }

        for i in 0..<(words.count-1) {
            var cur = Array(words[i])
            var next = Array(words[i+1])

            var k = 0
            while k < min(cur.count, next.count) {
                if cur[k] == next[k] {
                    k += 1
                    continue
                }
                if map[cur[k]]! > map[next[k]]! {
                    return false
                } else {
                    k += 1
                    break
                }
            }
            if cur[k-1] == next[k-1] && cur.count > next.count {
                return false
            }
        }

        return true
    }
}

/*
Solution 1:
sort the words by order first,
then check if sortedWords == words

Time Complexity: O(nlogn)
- n is words.count

Space Complexity: O(1)
- build 26 length map
*/
class Solution1 {
    func isAlienSorted(_ words: [String], _ order: String) -> Bool {
        // make order map
        var map = [Character: Int]()
        for (i, c) in order.enumerated() {
            map[c] = i
        }

        var sortedWords = words.sorted(by: { first, second -> Bool in
            var str1 = Array(first)
            var str2 = Array(second)
            // print(str1, str2)

            // compare until min length of 2 strings
            for i in 0..<min(str1.count, str2.count) {
                if str1[i] == str2[i] {
                    continue
                }

                if map[str1[i]]! > map[str2[i]]! {
                    return false
                } else {
                    return true
                }
            }
            return str1.count <= str2.count
        })

        return sortedWords == words
    }
}