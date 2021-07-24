/*
A transformation sequence from word beginWord to word endWord using a dictionary wordList is a sequence of words beginWord -> s1 -> s2 -> ... -> sk such that:

Every adjacent pair of words differs by a single letter.
Every si for 1 <= i <= k is in wordList. Note that beginWord does not need to be in wordList.
sk == endWord
Given two words, beginWord and endWord, and a dictionary wordList, return all the shortest transformation sequences from beginWord to endWord, or an empty list if no such sequence exists. Each sequence should be returned as a list of the words [beginWord, s1, s2, ..., sk].



Example 1:

Input: beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log","cog"]
Output: [["hit","hot","dot","dog","cog"],["hit","hot","lot","log","cog"]]
Explanation: There are 2 shortest transformation sequences:
"hit" -> "hot" -> "dot" -> "dog" -> "cog"
"hit" -> "hot" -> "lot" -> "log" -> "cog"
Example 2:

Input: beginWord = "hit", endWord = "cog", wordList = ["hot","dot","dog","lot","log"]
Output: []
Explanation: The endWord "cog" is not in wordList, therefore there is no valid transformation sequence.


Constraints:

1 <= beginWord.length <= 5
endWord.length == beginWord.length
1 <= wordList.length <= 1000
wordList[i].length == beginWord.length
beginWord, endWord, and wordList[i] consist of lowercase English letters.
beginWord != endWord
All the words in wordList are unique.
*/

/*
Solution 2:
optimize solution 1 by using Set<String> as map.values

This is for help quick checking if nextList contains endWord

Time Complexity: O(word.count * wordList.count)
Space Complexity: O(word.count * wordList.count)
*/
class Solution {
    func findLadders(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> [[String]] {
        // process wordList, key is pattern, val is list of word match this pattern
        // String: Set<String>
        var map = getPattern(wordList)

        var queue = [(word: String, list: [String])]()
        queue.append((beginWord, [beginWord]))

        var visited = Set<String>()

        var res = [[String]]()
        while !queue.isEmpty {
            var cur = queue

            var nextQueue = [(word: String, list: [String])]()
            // find the shortest transformation lists
            var isFinded = false
            for (word, list) in cur {
                for i in word.indices {
                    var temp = word
                    temp.remove(at: i)
                    temp.insert("*", at: i)

                    if let nextList = map[temp] {
                        if nextList.contains(endWord) {
                            res.append(list+[endWord])
                            isFinded = true
                        } else {
                            for next in nextList {
                                if !visited.contains(next) {
                                    nextQueue.append((next, list+[next]))
                                }
                            }
                        }
                    }
                }

                // insert word at the end
                visited.insert(word)
            }

            if isFinded { break }
            queue = nextQueue
            // print(nextQueue)
        }

        return res
    }

    func getPattern(_ wordList: [String]) -> [String: Set<String>] {
        var map = [String: Set<String>]()
        for word in wordList {
            for i in word.indices {
                var temp = word
                temp.remove(at: i)
                temp.insert("*", at: i)
                map[temp, default: Set<String>()].insert(word)
            }
        }
        return map
    }
}

/*
Solution 1:
TLE
*/
class Solution {
    func findLadders(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> [[String]] {
        // process wordList, key is pattern, val is list of word match this pattern
        var map = getPattern(wordList)
        // print(map)

        var queue = [(word: String, list: [String], visited: Set<String>)]()
        queue.append((beginWord, [beginWord], Set([beginWord])))

        var res = [[String]]()
        while !queue.isEmpty {
            var cur = queue

            var nextQueue = [(word: String, list: [String], visited: Set<String>)]()
            // find the shortest transformation lists
            var isFinded = false
            for (word, list, visited) in cur {
                if word == endWord {
                    res.append(list)
                    isFinded = true
                    continue
                }

                for i in word.indices {
                    var temp = word
                    temp.remove(at: i)
                    temp.insert("*", at: i)

                    if let nextList = map[temp] {
                        for next in nextList {
                            if !visited.contains(next) {
                                nextQueue.append((next, list+[next], visited.union(Set([next]))))
                            }
                        }
                    }
                }
            }

            if isFinded { break }
            queue = nextQueue
            // print(nextQueue)
        }

        return res
    }

    func getPattern(_ wordList: [String]) -> [String: [String]] {
        var map = [String: [String]]()
        for word in wordList {
            for i in word.indices {
                var temp = word
                temp.remove(at: i)
                temp.insert("*", at: i)
                map[temp, default: [String]()].append(word)
            }
        }
        return map
    }
}