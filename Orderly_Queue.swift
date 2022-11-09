/*
You are given a string s and an integer k. You can choose one of the first k letters of s and append it at the end of the string..

Return the lexicographically smallest string you could have after applying the mentioned step any number of moves.



Example 1:

Input: s = "cba", k = 1
Output: "acb"
Explanation:
In the first move, we move the 1st character 'c' to the end, obtaining the string "bac".
In the second move, we move the 1st character 'b' to the end, obtaining the final result "acb".
Example 2:

Input: s = "baaca", k = 3
Output: "aaabc"
Explanation:
In the first move, we move the 1st character 'b' to the end, obtaining the string "aacab".
In the second move, we move the 3rd character 'c' to the end, obtaining the final result "aaabc".


Constraints:

1 <= k <= s.length <= 1000
s consist of lowercase English letters.
*/

/*
Solution 2:
optimize solution 1
use smallestIndex to help quick find smallest begin char

Time Complexity: O(n * n)
Space Complexity: O(n)
*/
class Solution {
    func orderlyQueue(_ s: String, _ k: Int) -> String {
        if k == 1 {
            // equal to rotate s, until smallest char in the begin
            var smallestIndex = 0
            var smallest = s
            var s = Array(s)
            let n = s.count
            for i in 0..<n {
                if s[i] < s[smallestIndex] {
                    smallestIndex = i
                    smallest = getRotateString(s, i)
                } else if s[i] == s[smallestIndex] {
                    let temp = getRotateString(s, i)
                    if temp < smallest {
                        smallest = temp
                        smallestIndex = i
                    }
                }
            }
            return smallest
        } else {
            // sort s
            return String(s.sorted())
        }
    }

    // rotate charArr to make index as beginning char
    // return rotated string
    func getRotateString(_ charArr: [Character], _ index: Int) -> String {
        return String(Array(charArr[index...] + charArr[..<index]))
    }
}

/*
Solution 1:
If k = 1, only rotations of s are possible, and the answer is the lexicographically smallest rotation.

If k > 1, any permutation of s is possible, and the answer is the letters of s written in lexicographic order.

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func orderlyQueue(_ s: String, _ k: Int) -> String {
        let n = s.count
        if k == 1 {
            var res = s
            var s = Array(s)
            for i in 0..<n {
                var temp = String(s[i...] + s[0..<i])
                if temp < res {
                    res = temp
                }
            }
            return res
        } else {
            return String(s.sorted())
        }
    }
}
