// Given a string and a string dictionary, find the longest string in the dictionary that can be formed by deleting some characters of the given string. If there are more than one possible results, return the longest word with the smallest lexicographical order. If there is no possible result, return the empty string.

// Example 1:
// Input:
// s = "abpcplea", d = ["ale","apple","monkey","plea"]

// Output: 
// "apple"
// Example 2:
// Input:
// s = "abpcplea", d = ["a","b","c"]

// Output: 
// "a"
// Note:
// All the strings in the input will only contain lower-case letters.
// The size of the dictionary won't exceed 1,000.
// The length of all the strings in the input won't exceed 1,000.

// Solution 1: iterative brute force
// Instead of using recursive generate to create the list of possible strings that can be formed using ss by performing delete operations, we can also do the same process iteratively. To do so, we use the concept of binary number generation.
// We can treat the given string ss along with a binary represenation corresponding to the indices of ss. The rule is that the character at the position ii has to be added to the newly formed string strstr only if there is a boolean 1 at the corresponding index in the binary representation of a number currently considered.
// We know a total of 2^nsuch binary numbers are possible if there are nn positions to be filled(nn also corresponds to the number of characters in ss). Thus, we consider all the numbers from 00 to 2^nin their binary representation in a serial order and generate all the strings possible using the above rule.
// The figure below shows an example of the strings generated for the given string ss:"sea".
// A problem with this method is that the maximum length of the string can be 32 only, since we make use of an integer and perform the shift operations on it to generate the binary numbers.
// 
// Time complexity : O(2^n). 2^nstrings are generated.
// Space complexity : O(2^n). List ll contains 2^nstrings.
class Solution {
    func findLongestWord(_ s: String, _ d: [String]) -> String {
        var set = Set(d)
        var s = Array(s)
        var list = [String]()
        for i in 0..<(1<<s.count) {
            var temp = String()
            for j in 0..<s.count {
                if ((i>>j) & 1) != 0 {
                    temp.append(s[j])
                }
            }
            list.append(temp)
        }
        
        var longest = String()
        for str in list {
            if set.contains(str), 
            str.count > longest.count || (str.count == longest.count && str < longest) {
                longest = str
            }
        }
        return longest
    }
}

// Solution 2: 
// The matching condition in the given problem requires that we need to consider the matching string in the dictionary with the longest length and in case of same length, the string which is smallest lexicographically. To ease the searching process, we can sort the given dictionary's strings based on the same criteria, such that the more favorable string appears earlier in the sorted dictionary.
// Now, instead of performing the deletions in ss, we can directly check if any of the words given in the dictionary(say xx) is a subsequence of the given string ss, starting from the beginning of the dictionary. This is because, if xx is a subsequence of ss, we can obtain xx by performing delete operations on ss.
// If xx is a subsequence of ss every character of xx will be present in ss. The following figure shows the way the subsequence check is done for one example:
// As soon as we find any such xx, we can stop the search immediately since we've already processed dd to our advantage.
// 
// Time complexity : O(n \cdot x \log n + n \cdot x)O(n⋅xlogn+n⋅x). Here nn refers to the number of strings in list dd and xx refers to average string length. Sorting takes O(n\log n)O(nlogn) and isSubsequence takes O(x)O(x) to check whether a string is a subsequence of another string or not.
// Space complexity : O(\log n)O(logn). Sorting takes O(\log n)O(logn) space in average case.
class Solution {
    func findLongestWord(_ s: String, _ d: [String]) -> String {
        var d = d.sorted(by: { first, second -> Bool in
            return first.count > second.count 
                || (first.count == second.count && first < second)
        })
        
        for str in d {
            if isSubsequence(s, str) {
                return str
            }
        }
        return String()
    }
    
    // check if y is x subsequence
    func isSubsequence(_ x: String, _ y: String) -> Bool {
        var xindex = x.startIndex
        var yindex = y.startIndex
        while xindex < x.endIndex, yindex < y.endIndex {
            if x[xindex] == y[yindex] {
                yindex = y.index(after: yindex)
            }
            xindex = x.index(after: xindex)
        }
        return yindex == y.endIndex
    }
}

// Solution 3: without sorting
// 
// Time complexity : O(n \cdot x)O(n⋅x). One iteration over all strings is required. Here nn refers to the number of strings in list dd and xx refers to average string length.
// Space complexity : O(x)O(x). max\_strmax_str variable is used.
class Solution {
    func findLongestWord(_ s: String, _ d: [String]) -> String {
        var longest = String()
        for str in d {
            if isSubsequence(s, str),
            longest.count < str.count || (longest.count == str.count && str < longest){
                longest = str
            }
        }
        return longest
    }
    
    // check if y is x subsequence
    func isSubsequence(_ x: String, _ y: String) -> Bool {
        var xindex = x.startIndex
        var yindex = y.startIndex
        while xindex < x.endIndex, yindex < y.endIndex {
            if x[xindex] == y[yindex] {
                yindex = y.index(after: yindex)
            }
            xindex = x.index(after: xindex)
        }
        return yindex == y.endIndex
    }
}