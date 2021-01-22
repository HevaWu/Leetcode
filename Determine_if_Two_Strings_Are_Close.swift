/*
Two strings are considered close if you can attain one from the other using the following operations:

Operation 1: Swap any two existing characters.
For example, abcde -> aecdb
Operation 2: Transform every occurrence of one existing character into another existing character, and do the same with the other character.
For example, aacabb -> bbcbaa (all a's turn into b's, and all b's turn into a's)
You can use the operations on either string as many times as necessary.

Given two strings, word1 and word2, return true if word1 and word2 are close, and false otherwise.

 

Example 1:

Input: word1 = "abc", word2 = "bca"
Output: true
Explanation: You can attain word2 from word1 in 2 operations.
Apply Operation 1: "abc" -> "acb"
Apply Operation 1: "acb" -> "bca"
Example 2:

Input: word1 = "a", word2 = "aa"
Output: false
Explanation: It is impossible to attain word2 from word1, or vice versa, in any number of operations.
Example 3:

Input: word1 = "cabbba", word2 = "abbccc"
Output: true
Explanation: You can attain word2 from word1 in 3 operations.
Apply Operation 1: "cabbba" -> "caabbb"
Apply Operation 2: "caabbb" -> "baaccc"
Apply Operation 2: "baaccc" -> "abbccc"
Example 4:

Input: word1 = "cabbba", word2 = "aabbss"
Output: false
Explanation: It is impossible to attain word2 from word1, or vice versa, in any amount of operations.
 

Constraints:

1 <= word1.length, word2.length <= 105
word1 and word2 contain only lowercase English letters.

Hint 1:
Operation 1 allows you to freely reorder the string.

Hint 2:
Operation 2 allows you to freely reassign the letters' frequencies.
*/

/*
Solution 2: 
use 2 dictionary to check 2 words

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func closeStrings(_ word1: String, _ word2: String) -> Bool {
		guard word1.count == word2.count else { returun false }
        var dic1 = [Character: Int]()
        var dic2 = [Character: Int]()
        for i in word1.indices {
            dic1[word1[i], default: 0] += 1
            dic2[word2[i], default: 0] += 1
        }
        return Set(dic1.keys) == Set(dic2.keys) 
        && Set(dic1.values) == Set(dic2.values)
    }
}

/*
Solution 1:
use 2 array to check each char appearence in word
then check if 2 arrays have same char

Time Complexity: O(n + 26 + nlogn)
Space Complexity: O(1)
*/
class Solution {
    func closeStrings(_ word1: String, _ word2: String) -> Bool {
        if word1.count != word2.count { return false }
        
        var arr1 = Array(repeating: 0, count: 26)
        var arr2 = Array(repeating: 0, count: 26)
        
        let asciia = Character("a").asciiValue!
        for i in word1.indices {
            arr1[Int(word1[i].asciiValue! - asciia)] += 1
            arr2[Int(word2[i].asciiValue! - asciia)] += 1
        }
        
        // check if 2 array have same existing chars
        for i in 0..<26 {
            if arr1[i] == 0, arr2[i] == 0 {
                continue
            }
            if (arr1[i] == 0) || (arr2[i] == 0) {
                print(arr1[i], arr2[i], arr1[i] ^ arr2[i])
                return false
            }
        }
        
        return arr1.sorted() == arr2.sorted()
    }
}