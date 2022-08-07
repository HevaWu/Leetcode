/*
Given a list of words, list of  single letters (might be repeating) and score of every character.

Return the maximum score of any valid set of words formed by using the given letters (words[i] cannot be used two or more times).

It is not necessary to use all characters in letters and each letter can only be used once. Score of letters 'a', 'b', 'c', ... ,'z' is given by score[0], score[1], ... , score[25] respectively.



Example 1:

Input: words = ["dog","cat","dad","good"], letters = ["a","a","c","d","d","d","g","o","o"], score = [1,0,9,5,0,0,3,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0]
Output: 23
Explanation:
Score  a=1, c=9, d=5, g=3, o=2
Given letters, we can form the words "dad" (5+1+5) and "good" (3+2+2+5) with a score of 23.
Words "dad" and "dog" only get a score of 21.
Example 2:

Input: words = ["xxxz","ax","bx","cx"], letters = ["z","a","b","c","x","x","x"], score = [4,4,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,5,0,10]
Output: 27
Explanation:
Score  a=4, b=4, c=4, x=5, z=10
Given letters, we can form the words "ax" (4+5), "bx" (4+5) and "cx" (4+5) with a score of 27.
Word "xxxz" only get a score of 25.
Example 3:

Input: words = ["leetcode"], letters = ["l","e","t","c","o","d"], score = [0,0,1,1,1,0,0,0,0,0,0,1,0,0,1,0,0,0,0,1,0,0,0,0,0,0]
Output: 0
Explanation:
Letter "e" can only be used once.


Constraints:

1 <= words.length <= 14
1 <= words[i].length <= 15
1 <= letters.length <= 100
letters[i].length == 1
score.length == 26
0 <= score[i] <= 10
words[i], letters[i] contains only lower case English letters.
*/

/*
Solution 1:
brute force all combinations

Time Complexity: O(2^n * m)
- n = words.count
- m = maximum words[i].count
Space Complexity: O(26 ^ n)
*/

class Solution {
    let ca = Character("a").asciiValue!

    var n = 0
    var words = [String]()
    var score = [Int]()
    var maxScore = 0

    func maxScoreWords(_ words: [String], _ letters: [Character], _ score: [Int]) -> Int {
        self.words = words
        self.score = score

        // convert letters to letterFreq
        // use to check if there is enough characters
        var letterFreq = Array(repeating: 0, count: 26)
        for c in letters {
            let index = Int(c.asciiValue! - ca)
            letterFreq[index] += 1
        }

        self.n = words.count
        check(0, 0, letterFreq)
        return self.maxScore
    }

    // help map all words to see if words can form into any comibinations
    func check(_ index: Int, _ curScore: Int,
               _ letterFreq: [Int]) {
        if index == self.n
        || letterFreq == Array(repeating: 0, count: 26) {
            self.maxScore = max(self.maxScore, curScore)
            return
        }

        // nextFreq if put word into combinations
        // check if words[index] can be formed from letterFreq
        var nextFreq = letterFreq
        var canForm = true
        var wordScore = 0
        for c in self.words[index] {
            let index = Int(c.asciiValue! - ca)
            nextFreq[index] -= 1
            if nextFreq[index] < 0 {
                canForm = false
                break
            }
            wordScore += self.score[index]
        }

        if canForm {
            // put word in combinations
            check(index+1, curScore + wordScore, nextFreq)
        }
        check(index+1, curScore, letterFreq)
    }
}