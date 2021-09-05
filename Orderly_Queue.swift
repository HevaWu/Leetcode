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