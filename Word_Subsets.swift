/*
We are given two arrays A and B of words.  Each word is a string of lowercase letters.

Now, say that word b is a subset of word a if every letter in b occurs in a, including multiplicity.  For example, "wrr" is a subset of "warrior", but is not a subset of "world".

Now say a word a from A is universal if for every b in B, b is a subset of a.

Return a list of all universal words in A.  You can return the words in any order.



Example 1:

Input: A = ["amazon","apple","facebook","google","leetcode"], B = ["e","o"]
Output: ["facebook","google","leetcode"]
Example 2:

Input: A = ["amazon","apple","facebook","google","leetcode"], B = ["l","e"]
Output: ["apple","google","leetcode"]
Example 3:

Input: A = ["amazon","apple","facebook","google","leetcode"], B = ["e","oo"]
Output: ["facebook","google"]
Example 4:

Input: A = ["amazon","apple","facebook","google","leetcode"], B = ["lo","eo"]
Output: ["google","leetcode"]
Example 5:

Input: A = ["amazon","apple","facebook","google","leetcode"], B = ["ec","oc","ceo"]
Output: ["facebook","leetcode"]


Note:

1 <= A.length, B.length <= 10000
1 <= A[i].length, B[i].length <= 10
A[i] and B[i] consist only of lowercase letters.
All words in A[i] are unique: there isn't i != j with A[i] == A[j].
*/

/*
Solution 1:
build memoB for recording char accurs in B

iteratively check each a
to see if a char array cover memoB

Time Complexity: O(B.count + A.count)
Space Complexity: O(1)
*/
class Solution {
    func wordSubsets(_ A: [String], _ B: [String]) -> [String] {
        let ascii_a = Character("a").asciiValue!

        var memoB = Array(repeating: 0, count: 26)
        var temp = Array(repeating: 0, count: 26)
        for b in B {
            temp = Array(repeating: 0, count: 26)
            for c in b {
                temp[Int(c.asciiValue! - ascii_a)] += 1
            }

            for i in 0..<26 {
                memoB[i] = max(memoB[i], temp[i])
            }
        }

        var isUniversal = true
        var res = [String]()
        for a in A {
            temp = Array(repeating: 0, count: 26)
            for c in a {
                temp[Int(c.asciiValue! - ascii_a)] += 1
            }

            isUniversal = true
            for i in 0..<26 {
                if temp[i] < memoB[i] {
                    isUniversal = false
                    break
                }
            }

            if isUniversal {
                res.append(a)
            }
        }
        return res
    }
}

// === Another coding style ===

class Solution {
    func wordSubsets(_ words1: [String], _ words2: [String]) -> [String] {
        // record char's most appearance time in each word
        var arr2 = Array(repeating: 0, count: 26)
        for b in words2 {
            // record char's freq in b
            var temp = Array(repeating: 0, count: 26)
            for c in b {
                temp[getIndex(c)] += 1
            }
            for i in 0..<26 {
                arr2[i] = max(arr2[i], temp[i])
            }
        }

        return words1.filter { isUniversal($0, arr2) }
    }

    func getIndex(_ c: Character) -> Int {
        let ascii_a = Character("a").asciiValue!
        return Int(c.asciiValue! - ascii_a)
    }

    func isUniversal(_ a: String, _ arr2: [Int]) -> Bool {
        var arr = Array(repeating: 0, count: 26)
        for c in a {
            let index = getIndex(c)
            arr[index] += 1
        }

        for i in 0..<26 {
            if arr2[i] > arr[i] { return false }
        }
        return true
    }
}