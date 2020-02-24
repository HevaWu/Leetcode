// This problem is an interactive problem new to the LeetCode platform.

// We are given a word list of unique words, each word is 6 letters long, and one word in this list is chosen as secret.

// You may call master.guess(word) to guess a word.  The guessed word should have type string and must be from the original list with 6 lowercase letters.

// This function returns an integer type, representing the number of exact matches (value and position) of your guess to the secret word.  Also, if your guess is not in the given wordlist, it will return -1 instead.

// For each test case, you have 10 guesses to guess the word. At the end of any number of calls, if you have made 10 or less calls to master.guess and at least one of these guesses was the secret, you pass the testcase.

// Besides the example test case below, there will be 5 additional test cases, each with 100 words in the word list.  The letters of each word in those testcases were chosen independently at random from 'a' to 'z', such that every word in the given word lists is unique.

// Example 1:
// Input: secret = "acckzz", wordlist = ["acckzz","ccbazz","eiowzz","abcczz"]

// Explanation:

// master.guess("aaaaaa") returns -1, because "aaaaaa" is not in wordlist.
// master.guess("acckzz") returns 6, because "acckzz" is secret and has all 6 matches.
// master.guess("ccbazz") returns 3, because "ccbazz" has 3 matches.
// master.guess("eiowzz") returns 2, because "eiowzz" has 2 matches.
// master.guess("abcczz") returns 4, because "abcczz" has 4 matches.

// We made 5 calls to master.guess and one of them was the secret, so we pass the test case.
// Note:  Any solutions that attempt to circumvent the judge will result in disqualification.

// Solution 1: Minimax with Heuristic
// We can guess that having less words in the word list is generally better. If the data is random, we can reason this is often the case.
// Now let's use the strategy of making the guess that minimizes the maximum possible size of the resulting word list. If we started with NN words in our word list, we can iterate through all possibilities for what the secret could be.
// Store H[i][j] as the number of matches of wordlist[i] and wordlist[j]. For each guess that hasn't been guessed before, do a minimax as described above, taking the guess that gives us the smallest group that might occur.
// 
// Time Complexity: O(N^2 \log N), where NN is the number of words, and assuming their length is O(1)O(1). Each call to solve is O(N^2), and the number of calls is bounded by O(\log N)O(logN).
// Space Complexity: O(N^2).
 /**
 * // This is the Master's API interface.
 * // You should not implement it, or speculate about its implementation
 * class Master {
 *     public func guess(word: String) -> Int {}
 * }
 */
class Solution {
    var match = [[Int]]()
    func findSecretWord(_ wordlist: [String], _ master: Master) {
        let n = wordlist.count
        match = Array(repeating: Array(repeating: 0, count: n), count: n)
        // find match for each 2 word in wordList
        for i in 0..<n {
            for j in i..<n {
                var count = 0
                for k in wordlist[i].indices {
                    if wordlist[i][k] == wordlist[j][k] {
                        count += 1
                    }
                }
                match[i][j] = count
                match[j][i] = count
            }
        }
        
        // possible word where secret would be
        var possible = Array(0..<n)
    
        var visited = [Int]()
        while !possible.isEmpty {
            var guess = pick(possible, visited)  
            var matches = master.guess(wordlist[guess])
            if matches == 6 {
                // finded
                return 
            }
            var nextPossible = [Int]()
            for j in possible {
                if match[guess][j] == matches {
                    nextPossible.append(j)
                }
            }
            possible = nextPossible
            visited.append(guess)
        }
    }
    
    private func pick(_ possible: [Int], _ visited: [Int]) -> Int {
        guard possible.count > 2 else { return possible[0] }
        var answer = possible
        var guess = -1
        for i in 0..<match.count {
            if !visited.contains(i) {
                var groups = Array(repeating: [Int](), count: 6)
                for j in possible {
                    if i != j {
                        groups[match[i][j]].append(j)   
                    }
                }
                var maxGroup = groups[0]
                for g in groups {
                    if g.count > maxGroup.count {
                        maxGroup = g
                    }
                }
                if maxGroup.count < answer.count {
                    answer = maxGroup
                    guess = i
                }
            }
        }
        return guess
    }
}



// Solution 2: 
/**
 * // This is the Master's API interface.
 * // You should not implement it, or speculate about its implementation
 * class Master {
 *     public func guess(word: String) -> Int {}
 * }
 */
class Solution {
    func findSecretWord(_ wordlist: [String], _ master: Master) {
        var possible = wordlist
        while let word = possible.randomElement() {
            let matches = master.guess(word)
            if matches == 6 { 
                // finded
                return 
            }
            
            var nextTry = [String]()
            for next in possible {
                guard next != word else { continue }
                var i = word.startIndex
                var j = next.startIndex
                var tempMatches = 0
                while i < word.endIndex {
                    if word[i] == next[j] {
                        tempMatches += 1
                    }
                    i = word.index(after: i)
                    j = next.index(after: j)
                }
                if tempMatches == matches {
                    nextTry.append(next)
                }
            }
            possible = nextTry
        }
    }
}