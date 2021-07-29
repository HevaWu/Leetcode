/*
Given a list of dominoes, dominoes[i] = [a, b] is equivalent to dominoes[j] = [c, d] if and only if either (a==c and b==d), or (a==d and b==c) - that is, one domino can be rotated to be equal to another domino.

Return the number of pairs (i, j) for which 0 <= i < j < dominoes.length, and dominoes[i] is equivalent to dominoes[j].



Example 1:

Input: dominoes = [[1,2],[2,1],[3,4],[5,6]]
Output: 1


Constraints:

1 <= dominoes.length <= 40000
1 <= dominoes[i][j] <= 9
*/

/*
Solution 1:
map
key is 2 digit decimal

Time Complexity: O(n)
- n is dominoes.count
Space Complexity: O(n)
- at most 9*9 = 81
*/
class Solution {
    func numEquivDominoPairs(_ dominoes: [[Int]]) -> Int {
        var map = [Int: Int]()
        for d in dominoes {
            let d1 = d[0]
            let d2 = d[1]

            let key = d1 < d2 ? d1 * 10 + d2 : d2 * 10 + d1
            map[key, default: 0] += 1
        }

        var pair = 0
        for v in map.values {
            if v >= 2 {
                // i, j in increasing order, so / 2 to make sure order
                pair += (v * (v-1)) / 2
            }
        }
        return pair
    }
}