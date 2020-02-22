// Design a search autocomplete system for a search engine. Users may input a sentence (at least one word and end with a special character '#'). For each character they type except '#', you need to return the top 3 historical hot sentences that have prefix the same as the part of sentence already typed. Here are the specific rules:

// The hot degree for a sentence is defined as the number of times a user typed the exactly same sentence before.
// The returned top 3 hot sentences should be sorted by hot degree (The first is the hottest one). If several sentences have the same degree of hot, you need to use ASCII-code order (smaller one appears first).
// If less than 3 hot sentences exist, then just return as many as you can.
// When the input is a special character, it means the sentence ends, and in this case, you need to return an empty list.
// Your job is to implement the following functions:

// The constructor function:

// AutocompleteSystem(String[] sentences, int[] times): This is the constructor. The input is historical data. Sentences is a string array consists of previously typed sentences. Times is the corresponding times a sentence has been typed. Your system should record these historical data.

// Now, the user wants to input a new sentence. The following function will provide the next character the user types:

// List<String> input(char c): The input c is the next character typed by the user. The character will only be lower-case letters ('a' to 'z'), blank space (' ') or a special character ('#'). Also, the previously typed sentence should be recorded in your system. The output will be the top 3 historical hot sentences that have prefix the same as the part of sentence already typed.

 
// Example:
// Operation: AutocompleteSystem(["i love you", "island","ironman", "i love leetcode"], [5,3,2,2])
// The system have already tracked down the following sentences and their corresponding times:
// "i love you" : 5 times
// "island" : 3 times
// "ironman" : 2 times
// "i love leetcode" : 2 times
// Now, the user begins another search:

// Operation: input('i')
// Output: ["i love you", "island","i love leetcode"]
// Explanation:
// There are four sentences that have prefix "i". Among them, "ironman" and "i love leetcode" have same hot degree. Since ' ' has ASCII code 32 and 'r' has ASCII code 114, "i love leetcode" should be in front of "ironman". Also we only need to output top 3 hot sentences, so "ironman" will be ignored.

// Operation: input(' ')
// Output: ["i love you","i love leetcode"]
// Explanation:
// There are only two sentences that have prefix "i ".

// Operation: input('a')
// Output: []
// Explanation:
// There are no sentences that have prefix "i a".

// Operation: input('#')
// Output: []
// Explanation:
// The user finished the input, the sentence "i a" should be saved as a historical sentence in system. And the following input will be counted as a new search.

 
// Note:

// The input sentence will always start with a letter and end with '#', and only one blank space will exist between two words.
// The number of complete sentences that to be searched won't exceed 100. The length of each sentence including those in the historical data won't exceed 100.
// Please use double-quote instead of single-quote when you write test cases even for a character input.
// Please remember to RESET your class variables declared in class AutocompleteSystem, as static/class variables are persisted across multiple test cases. Please see here for more details.

// Solution 1: map, brute force
// 
// Time complexity: AutocompleteSystem() takes O(k*l)O(k∗l) time. This is because, putting an entry in a hashMap takes O(1)O(1) time. But, to create a hash value for a sentence of average length kk, it will be scanned atleast once. We need to put ll such entries in the mapmap.
// input() takes O\big(n+m \log m\big)O(n+mlogm) time. We need to iterate over the list of sentences, in mapmap, entered till now(say with a count nn), taking O(n)O(n) time, to populate the listlist used for finding the hot sentences. Then, we need to sort the listlist of length mm, taking O\big(m \log m\big)O(mlogm) time.
// Space complexity: O(n) <- n is sentences length
class AutocompleteSystem {
    var map = [String: Int]()
    var complete = String()

    init(_ sentences: [String], _ times: [Int]) {
        for i in 0..<sentences.count {
            map[sentences[i], default: 0] += times[i]
        }
    }
    
    func input(_ c: Character) -> [String] {
        if c == "#" { 
            // reset complete
            map[complete, default: 0] += 1
            complete = String()
            return [String]()
        }
        complete.append(c)
        return findHot3()
    }
    
    func findHot3() -> [String] {
        let keyList = map.keys.filter { $0.hasPrefix(complete) }
        let sortedKeyList = keyList.sorted { first, second -> Bool in
            guard map[first] == map[second] else { 
                return map[first, default: 0] > map[second, default: 0] 
            }
            var common = first.commonPrefix(with: second)
            var nextFirst = first.dropFirst(common.count)
            var nextSecond = second.dropFirst(common.count)
            return (nextFirst.first?.asciiValue ?? 0) < (nextSecond.first?.asciiValue ?? 0) 
        }
        
        guard !sortedKeyList.isEmpty else { return [String]() }
        if sortedKeyList.count <= 3 { return sortedKeyList }
        return Array(sortedKeyList[0..<3])
    }
}

/**
 * Your AutocompleteSystem object will be instantiated and called as such:
 * let obj = AutocompleteSystem(sentences, times)
 * let ret_1: [String] = obj.input(c)
 */

// Solution 2: Trie 
// Strings are stored in a top to bottom manner on the basis of their prefix in a trie. All prefixes of length 1 are stored at until level 1, all prefixes of length 2 are sorted at until level 2 and so on.
// 
// AutocompleteSystem() takes O(k*l)O(k∗l) time. We need to iterate over ll sentences each of average length kk, to create the trie for the given set of sentencessentences.
// input() takes O\big(p+q+m \log m\big)O(p+q+mlogm) time. Here, pp refers to the length of the sentence formed till now, \text{cur\_sent}cur_sent. qq refers to the number of nodes in the trie considering the sentence formed till now as the root node. Again, we need to sort the listlist of length mm indicating the options available for the hot sentences, which takes O\big(m \log m\big)O(mlogm) time.
class AutocompleteSystem {
    var root = TrieNode()
    var complete = String()

    init(_ sentences: [String], _ times: [Int]) {
        for i in 0..<sentences.count {
            insertTrieNode(root, sentences[i], times[i])
        }
    }
    
    private func insertTrieNode(_ root: TrieNode, _ sentence: String, _ time: Int) {
        var node = root
        for c in sentence {
            let index = getIndex(c)
            if node.children[index] == nil {
                node.children[index] = TrieNode()
            }
            node = node.children[index]!
        }
        node.time += time
    }
    
    private func getIndex(_ c: Character) -> Int {
        let asciiA = Character("a").asciiValue ?? 0
        return c == " " ? 26 : Int((c.asciiValue ?? 0) - asciiA)
    }
    
    func input(_ c: Character) -> [String] {
        if c == "#" {
            // insert & reset complete
            insertTrieNode(root, complete, 1)
            complete = String()
            return [String]()
        } else {
            complete.append(c)
            return findHot3()
        }
    }
    
    private func findHot3() -> [String] {
        // find match prefix sentences
        var node = root
        for c in complete {
            let index = getIndex(c)
            if node.children[index] == nil {
                return [String]()
            }
            node = node.children[index]!
        }
        var list = [(String, Int)]()
        getRemainList(node, complete, &list)
        
        // sort list 
        var sortedList = list.sorted { first, second -> Bool in
            if first.1 == second.1 {
                return first.0 < second.0
            } else {
                return first.1 > second.1
            }
        }
        var result = [String]()
        let len = min(3, sortedList.count)
        for i in 0..<len {
            result.append(sortedList[i].0)
        }
        return result
    }
    
    private func getRemainList(_ node: TrieNode, _ str: String, _ list: inout [(String, Int)]) {
        if node.time > 0 {
            list.append((str, node.time))
        }
        for i in 0..<26 {
            if node.children[i] != nil {
                let char = UnicodeScalar(UnicodeScalar("a").value + UInt32(i))!
                getRemainList(node.children[i]!, str + String(char), &list)
            }
        }
        // check " "
        if node.children[26] != nil {
            getRemainList(node.children[26]!, str+" ", &list)
        }
    }
}

class TrieNode {
    var time = 0
    var children: [TrieNode?] = Array(repeating: nil, count: 27)
}

/**
 * Your AutocompleteSystem object will be instantiated and called as such:
 * let obj = AutocompleteSystem(sentences, times)
 * let ret_1: [String] = obj.input(c)
 */
