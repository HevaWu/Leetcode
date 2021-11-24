/*
You are given two lists of closed intervals, firstList and secondList, where firstList[i] = [starti, endi] and secondList[j] = [startj, endj]. Each list of intervals is pairwise disjoint and in sorted order.

Return the intersection of these two interval lists.

A closed interval [a, b] (with a <= b) denotes the set of real numbers x with a <= x <= b.

The intersection of two closed intervals is a set of real numbers that are either empty or represented as a closed interval. For example, the intersection of [1, 3] and [2, 4] is [2, 3].



Example 1:


Input: firstList = [[0,2],[5,10],[13,23],[24,25]], secondList = [[1,5],[8,12],[15,24],[25,26]]
Output: [[1,2],[5,5],[8,10],[15,23],[24,24],[25,25]]
Example 2:

Input: firstList = [[1,3],[5,9]], secondList = []
Output: []
Example 3:

Input: firstList = [], secondList = [[4,8],[10,12]]
Output: []
Example 4:

Input: firstList = [[1,7]], secondList = [[3,10]]
Output: [[3,7]]


Constraints:

0 <= firstList.length, secondList.length <= 1000
firstList.length + secondList.length >= 1
0 <= starti < endi <= 109
endi < starti+1
0 <= startj < endj <= 109
endj < startj+1
*/

/*
Solution2:
Optimize solution 1
*/
class Solution {
    func intervalIntersection(_ firstList: [[Int]], _ secondList: [[Int]]) -> [[Int]] {
        let n1 = firstList.count
        let n2 = secondList.count

        var res = [[Int]]()

        var i1 = 0
        var i2 = 0
        while i1 < n1, i2 < n2 {
            let p1 = firstList[i1]
            let p2 = secondList[i2]

            let start = max(p1[0], p2[0])
            let end = min(p1[1], p2[1])

            if start <= end {
                res.append([start, end])
            }

            if p1[1] < p2[1] {
                i1 += 1
            } else {
                i2 += 1
            }
        }

        return res
    }
}

/*
Solution1:
compare intervals one by one

Time Complexity: O(n1 + n2 )
Space Complexity: O(1)
*/
class Solution {
    func intervalIntersection(_ firstList: [[Int]], _ secondList: [[Int]]) -> [[Int]] {
        let n1 = firstList.count
        let n2 = secondList.count

        var res = [[Int]]()

        var i1 = 0
        var i2 = 0
        while i1 < n1, i2 < n2 {
            let p1 = firstList[i1]
            let p2 = secondList[i2]

            if p1[0] <= p2[1] && p2[0] <= p1[1] {
                // find a intersection betweeen p1 and p2
                res.append([max(p1[0], p2[0]), min(p1[1], p2[1])])
                if p1[1] < p2[1] {
                    // update p1 to next interval
                    i1 += 1
                } else {
                    i2 += 1
                }
            } else if p1[0] > p2[1] {
                // update p2 to next interval
                i2 += 1
            } else {
                // p2[0] > p1[1], update p1 to next interval
                i1 += 1
            }
        }

        return res
    }
}