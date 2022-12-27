/*
You have n bags numbered from 0 to n - 1. You are given two 0-indexed integer arrays capacity and rocks. The ith bag can hold a maximum of capacity[i] rocks and currently contains rocks[i] rocks. You are also given an integer additionalRocks, the number of additional rocks you can place in any of the bags.

Return the maximum number of bags that could have full capacity after placing the additional rocks in some bags.



Example 1:

Input: capacity = [2,3,4,5], rocks = [1,2,4,4], additionalRocks = 2
Output: 3
Explanation:
Place 1 rock in bag 0 and 1 rock in bag 1.
The number of rocks in each bag are now [2,3,4,4].
Bags 0, 1, and 2 have full capacity.
There are 3 bags at full capacity, so we return 3.
It can be shown that it is not possible to have more than 3 bags at full capacity.
Note that there may be other ways of placing the rocks that result in an answer of 3.
Example 2:

Input: capacity = [10,2,2], rocks = [2,2,0], additionalRocks = 100
Output: 3
Explanation:
Place 8 rocks in bag 0 and 2 rocks in bag 2.
The number of rocks in each bag are now [10,2,2].
Bags 0, 1, and 2 have full capacity.
There are 3 bags at full capacity, so we return 3.
It can be shown that it is not possible to have more than 3 bags at full capacity.
Note that we did not use all of the additional rocks.


Constraints:

n == capacity.length == rocks.length
1 <= n <= 5 * 104
1 <= capacity[i] <= 109
0 <= rocks[i] <= capacity[i]
1 <= additionalRocks <= 109
*/

/*
Solution 1:
find current remain spaces
then fill bags from smallest remain space bag, to make sure get maximum fullable bag

Time Complexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func maximumBags(_ capacity: [Int], _ rocks: [Int], _ additionalRocks: Int) -> Int {
        let n = capacity.count
        var spaces = Array(repeating: 0, count: n)
        for i in 0..<n {
            spaces[i] = capacity[i] - rocks[i]
        }
        spaces.sort()
        var bags = 0
        var additionalRocks = additionalRocks
        while bags < n, additionalRocks > 0 {
            let canFill = min(spaces[bags], additionalRocks)
            additionalRocks -= canFill
            spaces[bags] -= canFill
            bags += 1
        }
        return spaces[bags-1] == 0 ? bags : bags-1
    }
}
