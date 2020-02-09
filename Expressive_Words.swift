// Sometimes people repeat letters to represent extra feeling, such as "hello" -> "heeellooo", "hi" -> "hiiii".  In these strings like "heeellooo", we have groups of adjacent letters that are all the same:  "h", "eee", "ll", "ooo".

// For some given string S, a query word is stretchy if it can be made to be equal to S by any number of applications of the following extension operation: choose a group consisting of characters c, and add some number of characters c to the group so that the size of the group is 3 or more.

// For example, starting with "hello", we could do an extension on the group "o" to get "hellooo", but we cannot get "helloo" since the group "oo" has size less than 3.  Also, we could do another extension like "ll" -> "lllll" to get "helllllooo".  If S = "helllllooo", then the query word "hello" would be stretchy because of these two extension operations: query = "hello" -> "hellooo" -> "helllllooo" = S.

// Given a list of query words, return the number of words that are stretchy. 

 

// Example:
// Input: 
// S = "heeellooo"
// words = ["hello", "hi", "helo"]
// Output: 1
// Explanation: 
// We can extend "e" and "o" in the word "hello" to get "heeellooo".
// We can't extend "helo" to get "heeellooo" because the group "ll" is not size 3 or more.
 

// Notes:

// 0 <= len(S) <= 100.
// 0 <= len(words) <= 100.
// 0 <= len(words[i]) <= 100.
// S and all words in words consist only of lowercase letters
 
//  Solution 1: recursive find matching word
// - go through words, for each word, check if this word is matching
// - check this word, use findedBegin boolean to help confirming if this string needed to be search from beginning again.
// 		- search through it, to find if the character in word match
// 		- if begin already be found, current one is not equal, reset the begin
// 		- update indexS & indexWord by check the continuous char
// 		- use findStretch to help finding the continuous char in string
// 		- use to check if we need to reset word index
// 			disInS != disInWord, disInS < disInWord || disInS == 0 || disInS == 2 
// 
// Time Complexity: O(mn), words length & S length
// Space Complexity: O(n), use array to help checking S
class Solution {
    func expressiveWords(_ S: String, _ words: [String]) -> Int {
        guard !S.isEmpty, !words.isEmpty else { return 0 }
        var expreNum = 0
        for word in words {
            if canExtend(word, in: S) {
                expreNum += 1
            }
        }
        return expreNum
    }
    
    func canExtend(_ word: String, in S: String) -> Bool {
        guard !word.isEmpty, S.count > word.count else { return false }
        
        // search through S
        var word = Array(word)
        var S = Array(S)  
        var indexS = 0
        var indexWord = 0
        var findedBegin = false
        
        while indexS < S.count, indexWord < word.count {
            let char = word[indexWord]
            // find the first indexS equal to char
            guard S[indexS] == char else { 
                if findedBegin {
                    // if previously already find one char, current is not equal, refresh
                    findedBegin = false
                    indexWord = 0
                }
                indexS += 1
                continue 
            }
            
            findedBegin = true
            let charInWord = findStretch(of: char, in: word, from: indexWord)
            let charInS = findStretch(of: char, in: S, from: indexS)
            
            let disInWord = charInWord - indexWord + 1
            let disInS = charInS - indexS + 1

            if disInS != disInWord,
            disInS < disInWord || disInS == 0 || disInS == 2 {
                // it is not stretching, refresh
                findedBegin = false
                indexWord = 0
            } else {
                indexWord = charInWord + 1
            }
            indexS = charInS + 1
        }
        return findedBegin && indexWord == word.count && indexS == S.count
    }
    
    func findStretch(of char: Character, in S: [Character], from index: Int) -> Int {
        for i in index..<S.count {
            guard S[i] == char else { return i-1 }   
        }
        return S.count - 1
    }
}