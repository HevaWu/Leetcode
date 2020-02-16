// Given two words (beginWord and endWord), and a dictionary's word list, find the length of shortest transformation sequence from beginWord to endWord, such that:

// Only one letter can be changed at a time.
// Each transformed word must exist in the word list. Note that beginWord is not a transformed word.
// Note:

// Return 0 if there is no such transformation sequence.
// All words have the same length.
// All words contain only lowercase alphabetic characters.
// You may assume no duplicates in the word list.
// You may assume beginWord and endWord are non-empty and are not the same.
// Example 1:

// Input:
// beginWord = "hit",
// endWord = "cog",
// wordList = ["hot","dot","dog","lot","log","cog"]

// Output: 5

// Explanation: As one shortest transformation is "hit" -> "hot" -> "dot" -> "dog" -> "cog",
// return its length 5.
// Example 2:

// Input:
// beginWord = "hit"
// endWord = "cog"
// wordList = ["hot","dot","dog","lot","log"]

// Output: 0

// Explanation: The endWord "cog" is not in wordList, therefore no possible transformation.

// Solution 1: BFS
// Do the pre-processing on the given wordList and find all the possible generic/intermediate states. Save these intermediate states in a dictionary with key as the intermediate word and value as the list of words which have the same intermediate word.
// Push a tuple containing the beginWord and 1 in a queue. The 1 represents the level number of a node. We have to return the level of the endNode as that would represent the shortest sequence/distance from the beginWord.
// To prevent cycles, use a visited dictionary.
// While the queue has elements, get the front element of the queue. Let's call this word as current_word.
// Find all the generic transformations of the current_word and find out if any of these transformations is also a transformation of other words in the word list. This is achieved by checking the all_combo_dict.
// The list of words we get from all_combo_dict are all the words which have a common intermediate state with the current_word. These new set of words will be the adjacent nodes/words to current_word and hence added to the queue.
// Hence, for each word in this list of intermediate words, append (word, level + 1) into the queue where level is the level for the current_word.
// 
// iTme Complexity: O(M \times N)O(M×N), where MM is the length of words and NN is the total number of words in the input word list. Finding out all the transformations takes MM iterations for each of the NN words. Also, breadth first search in the worst case might go to each of the NN words.
// Space Complexity: O(M \times N)O(M×N), to store all MM transformations for each of the NN words, in the all_combo_dict dictionary. Visited dictionary is of NN size. Queue for BFS in worst case would need space for all NN words.
class Solution {
    // key is one character replaced by * pattern
    // value is string match this pattern
    var map = [String: Set<String>]()
    
    func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
        if beginWord != endWord, wordList.isEmpty { return 0 }
        
        for word in wordList {
            matchMap(word)
        }
    
        var queue = [(beginWord, 1)]
        
        // visited pattern in map
        var visited = Set<String>()
        
        while !queue.isEmpty {
            var node = queue.removeLast()
            let word = node.0
            let level = node.1
            
            for i in word.indices {
                var temp = word
                temp.remove(at: i)
                temp.insert("*", at: i)
                
                if !visited.contains(temp) {
                    visited.insert(temp)
                    
                    guard map.keys.contains(temp) else { continue }
                    if map[temp]!.contains(endWord) {
                        return level + 1
                    }
                    
                    for w in map[temp]! {
                        queue.insert((w, level+1), at: 0)
                    }
                }
            }
        }
        return 0
    }
    
    func matchMap(_ word: String) {
        for i in word.indices {
            var temp = word
            temp.remove(at: i)
            temp.insert("*", at: i)
            
            map[temp, default: Set<String>()].insert(word)
        }
    }
}

// Solution 2: Bidirectional Breadth First Search
// The algorithm is very similar to the standard BFS based approach we saw earlier.
// The only difference is we now do BFS starting two nodes instead of one. This also changes the termination condition of our search.
// We now have two visited dictionaries to keep track of nodes visited from the search starting at the respective ends.
// If we ever find a node/word which is in the visited dictionary of the parallel search we terminate our search, since we have found the meet point of this bidirectional search. It's more like meeting in the middle instead of going all the way through.
// Termination condition for bidirectional search is finding a word which is already been seen by the parallel search.
// The shortest transformation sequence is the sum of levels of the meet point node from both the ends. Thus, for every visited node we save its level as value in the visited dictionary.
// 
// Time Complexity: O(M \times N)O(M×N), where MM is the length of words and NN is the total number of words in the input word list. Similar to one directional, bidirectional also takes M*NM∗N for finding out all the transformations. But the search time reduces to half, since the two parallel searches meet somewhere in the middle.
// Space Complexity: O(M \times N)O(M×N), to store all MM transformations for each of the NN words, in the all_combo_dict dictionary, same as one directional. But bidirectional reduces the search space. It narrows down because of meeting in the middle.
class Solution {
    // pattern map, key is pattern, value is string which match this pattern
    var map = [String: Set<String>]()
    
    func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
        guard wordList.contains(endWord) else { return 0 }
        if beginWord != endWord, wordList.isEmpty { return 0 }
        
        for word in wordList {
            matchPattern(word)
        }
        
        // bfs 2 pointer seperately for begin & end
        var beginQ = [(beginWord, 1)]
        var endQ = [(endWord, 1)]
                
        // first is string, second is level
        var beginVisited = [String: Int]()
        beginVisited[beginWord] = 1
        var endVisited = [String: Int]()
        endVisited[endWord] = 1
        
        while !beginQ.isEmpty, !endQ.isEmpty {
            if let begin = check(&beginQ, &beginVisited, &endVisited) {
                return begin
            }
            
            if let end = check(&endQ, &endVisited, &beginVisited) {
                return end
            }
        }
        
        return 0
    }
    
    func check(_ queue: inout [(String, Int)], _ firstVisited: inout [String: Int], _ secondVisited: inout [String: Int]) -> Int? {
        let node = queue.removeLast()
        let word = node.0
        var level = node.1
        
        for i in word.indices {
            var temp = word
            temp.remove(at: i)
            temp.insert("*", at: i)
            
            guard map[temp] != nil else { continue }
            for next in map[temp]! {
                if secondVisited.keys.contains(next) {
                    return level + secondVisited[next]!
                }
                
                if !firstVisited.keys.contains(next) {
                    firstVisited[next] = level + 1
                    queue.insert((next, level + 1), at: 0)
                }
            }
        }
        return nil
    }
    
    func matchPattern(_ word: String) {
        for i in word.indices {
            var temp = word
            temp.remove(at: i)
            temp.insert("*", at: i)
            
            map[temp, default: Set<String>()].insert(word)
        }
    }
}