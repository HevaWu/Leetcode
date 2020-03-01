// From any string, we can form a subsequence of that string by deleting some number of characters (possibly no deletions).

// Given two strings source and target, return the minimum number of subsequences of source such that their concatenation equals target. If the task is impossible, return -1.

 

// Example 1:

// Input: source = "abc", target = "abcbc"
// Output: 2
// Explanation: The target "abcbc" can be formed by "abc" and "bc", which are subsequences of source "abc".
// Example 2:

// Input: source = "abc", target = "acdbc"
// Output: -1
// Explanation: The target string cannot be constructed from the subsequences of source string due to the character "d" in target string.
// Example 3:

// Input: source = "xyz", target = "xzyxz"
// Output: 3
// Explanation: The target string can be constructed as follows "xz" + "y" + "xz".
 

// Constraints:

// Both the source and target strings consist of only lowercase English letters from "a"-"z".
// The lengths of source and target string are between 1 and 1000.

// concatenation(连接)

// Solution 1: directly go through, 2 pointer , one for source, one for target
// 
// Time complexity: O(mn) m is source.count, n is target.count
// Space complexity: O(1)
class Solution {
    func shortestWay(_ source: String, _ target: String) -> Int {
        var source = Array(source)
        var target = Array(target)
        
        var count = 0
        var tIndex = 0
        while tIndex < target.count {
            var sIndex = 0
            var isFound = false
            while sIndex < source.count, tIndex < target.count {
                if source[sIndex] == target[tIndex] {
                    isFound = true
                    tIndex += 1
                }
                sIndex += 1
            }
            if isFound {
                count += 1
            } else {
                return -1
            }
        }
        return count
    }
}

// Solution 2: recursive
// go through target to check if there is a sub in source.
// 
// Time complexity: O(mn) m is source length, n is target length
// Space complexity: O(m^2) subsource string
class Solution {
    func shortestWay(_ source: String, _ target: String) -> Int {
        var count = 0
        
        var i = target.startIndex
        while i < target.endIndex {
            if let next = check(source, source, target, i) {
                count += 1
                i = target.index(after: next)
            } else {
                // cannot find correct subsequences
                return -1
            }
        }
        return count
    }
    
    // go through source to check subsequences, 
    // if can be find, return next index
    // if cannot find, return nil
    func check(_ source: String, _ subSource: String, _ target: String, _ index: String.Index) -> String.Index? {
        // cannot find this character in source
        guard source.contains(target[index]) else { return nil }

        if let first = subSource.firstIndex(of: target[index]) {
            let sIndex = subSource.index(after: first)
            let tIndex = target.index(after: index)
            guard sIndex < source.endIndex, tIndex < target.endIndex else { 
                return index 
            }
            return check(source, String(subSource[sIndex...]), target, tIndex)
        } else {
            if index > target.startIndex { 
                // cannot find the char in subSource, but this char might exist at pre-part our subSource, return the pre-index, for doing it again at later
                return target.index(before: index)
            } else {
                // cannot find the char in whole source
                return nil
            }
        }
    }
}