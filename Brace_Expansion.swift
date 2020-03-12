// A string S represents a list of words.

// Each letter in the word has 1 or more options.  If there is one option, the letter is represented as is.  If there is more than one option, then curly braces delimit the options.  For example, "{a,b,c}" represents options ["a", "b", "c"].

// For example, "{a,b,c}d{e,f}" represents the list ["ade", "adf", "bde", "bdf", "cde", "cdf"].

// Return all words that can be formed in this manner, in lexicographical order.

 

// Example 1:

// Input: "{a,b}c{d,e}f"
// Output: ["acdf","acef","bcdf","bcef"]
// Example 2:

// Input: "abcd"
// Output: ["abcd"]
 

// Note:

// 1 <= S.length <= 50
// There are no nested curly brackets.
// All characters inside a pair of consecutive opening and ending curly brackets are different.

// Solution 1: force
// 
// Time complexity: O(m+ nlogn) m is string len, n is final output len
// Space complexity: O(n)
class Solution {
    func expand(_ S: String) -> [String] {
        guard !S.isEmpty else { return [String]() }
        var list = [String]()
        
        var S = Array(S)
        var i = 0
        while i < S.count {
            if S[i] == "{" {
                var preList = list
                var temp = preList
                var isFirst = true
                
                var j = i+1 
                while j < S.count {

                    if S[j] == "}" { break }
                    
                    // skip ,
                    if S[j] == "," { 
                        j += 1
                        continue 
                    }
                      
                    if temp.isEmpty {
                        temp.append(String(S[j]))
                    } else {
                        for k in 0..<temp.count {
                            temp[k].append(S[j])
                        }
                    }
                                        
                    if isFirst {
                        list = temp
                        isFirst = false
                    } else {
                        list.append(contentsOf: temp)
                    }
                    temp = preList
                    j += 1
                }
                i = j + 1
            } else {
                // letter
                var str = String()
                
                var j = i
                while j < S.count {
                    if S[j] == "{" { break }
                    str.append(S[j])
                    j += 1
                }
                                
                if list.isEmpty {
                    list.append(str)
                } else {
                    for k in 0..<list.count {
                        list[k].append(str)
                    }
                }
                
                i = j
            }
        }
        list.sort()
        return list
    }
}

// Solution 2: backtracking
// Put S into a [[Character]]() first,  
// backtracking the list at the end
//
// Time complexity: O(nlogn + n)
// Space complexity: O(n)
class Solution {
    func expand(_ S: String) -> [String] {
        var list = [[Character]]()
        var temp = [Character]()
        
        var inBrace = false
        for s in S {
            if s == "{" {
                inBrace = true
            } else if s == "," {
                continue
            } else if s == "}" {
				// sort temp first, since we will provide the lexicographical order
                list.append(temp.sorted())
                temp = [Character]()
                inBrace = false
            } else {
                // letter
                if inBrace {
                    temp.append(s)
                } else {
                    list.append([s])
                }
            }
        }
        
        var words = [String]()
        backtrack(0, list, String(), &words)
        return words
    }
    
    func backtrack(_ index: Int, _ list: [[Character]], _ str: String, _ words: inout [String]) {
        if index == list.count { 
            words.append(str)
            return
        }
        
        for i in list[index] {
            backtrack(index+1, list, str+String(i), &words)
        }
    }
}