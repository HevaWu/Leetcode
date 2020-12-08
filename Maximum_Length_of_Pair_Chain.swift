/*
You are given n pairs of numbers. In every pair, the first number is always smaller than the second number.

Now, we define a pair (c, d) can follow another pair (a, b) if and only if b < c. Chain of pairs can be formed in this fashion.

Given a set of pairs, find the length longest chain which can be formed. You needn't use up all the given pairs. You can select pairs in any order.

Example 1:
Input: [[1,2], [2,3], [3,4]]
Output: 2
Explanation: The longest chain is [1,2] -> [3,4]
Note:
The number of given pairs will be in the range [1, 1000].
*/

/*
Solution: Greedy

sort by end: after sorting we know: s1<e1<e2 and s2<e2
(in order to make it be easier, we do not consider about "==" case).
s2 has three possible positions : (first) s1 (second) e1 (third) e2
Hence, we have 3 cases.
case 1: s2<s1<e1 <e2
case 2:s1<s2<e1<e2
case 3:s1<e1< s2 <e2

TimeComplexity:
O(nlogn) where n is pairs.count
*/

class Solution {
    func findLongestChain(_ pairs: [[Int]]) -> Int {
        if pairs.count == 0 { return 0 }
        
        // sort by end
        let pairs = pairs.sorted { $0[1] < $1[1] }
        
        var cur = Int.min
        var maxChain = 0
        
        for p in pairs {
            if cur < p[0] {
                cur = p[1]
                maxChain += 1
            }
        }
        
        return maxChain
    }
}

/*
Solution 2: DP

sort by start
then check if pairs[i] can be follwe pairs[j]
pairs[j][1] < pairs[i][0]

Time Complexity:
O(n^2) where n is pairs.count
*/
class Solution {
    func findLongestChain(_ pairs: [[Int]]) -> Int {
        if pairs.count == 0 { return 0 }
        
        // sort by start
        let pairs = pairs.sorted { $0[0] < $1[0] }
        
        let n = pairs.count
        var dp = Array(repeating: 1, count: n)
        
        for i in 0..<n {
            var j = 0
            while j < i {
                // check if pairs[i] can follow pairs[j]
                // pairs[j][1] < pairs[i][0]
                dp[i] = max(dp[i], pairs[j][1] < pairs[i][0] ? dp[j] + 1 : dp[j])
                j += 1
            }
        }
        
        return dp[n-1]
    }
}