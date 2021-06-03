/*
Given a rectangular cake with height h and width w, and two arrays of integers horizontalCuts and verticalCuts where horizontalCuts[i] is the distance from the top of the rectangular cake to the ith horizontal cut and similarly, verticalCuts[j] is the distance from the left of the rectangular cake to the jth vertical cut.

Return the maximum area of a piece of cake after you cut at each horizontal and vertical position provided in the arrays horizontalCuts and verticalCuts. Since the answer can be a huge number, return this modulo 10^9 + 7.



Example 1:



Input: h = 5, w = 4, horizontalCuts = [1,2,4], verticalCuts = [1,3]
Output: 4
Explanation: The figure above represents the given rectangular cake. Red lines are the horizontal and vertical cuts. After you cut the cake, the green piece of cake has the maximum area.
Example 2:



Input: h = 5, w = 4, horizontalCuts = [3,1], verticalCuts = [1]
Output: 6
Explanation: The figure above represents the given rectangular cake. Red lines are the horizontal and vertical cuts. After you cut the cake, the green and yellow pieces of cake have the maximum area.
Example 3:

Input: h = 5, w = 4, horizontalCuts = [3], verticalCuts = [3]
Output: 9


Constraints:

2 <= h, w <= 10^9
1 <= horizontalCuts.length < min(h, 10^5)
1 <= verticalCuts.length < min(w, 10^5)
1 <= horizontalCuts[i] < h
1 <= verticalCuts[i] < w
It is guaranteed that all elements in horizontalCuts are distinct.
It is guaranteed that all elements in verticalCuts are distinct.
   Hide Hint #1
Sort the arrays, then compute the maximum difference between two consecutive elements for horizontal cuts and vertical cuts.
   Hide Hint #2
The answer is the product of these maximum values in horizontal cuts and vertical cuts.
*/

/*
Solution 1:

Idea:
- sort horizontalCuts , verticalCuts
- find maxCut area after each cuts
- return (mh*mv) % mod

Time Complexity: O(cuts.count)
Space Complexity: O(cuts.count)
*/
class Solution {
    func maxArea(_ h: Int, _ w: Int, _ horizontalCuts: [Int], _ verticalCuts: [Int]) -> Int {
        let mod = Int(1e9 + 7)

        var horizontalCuts = horizontalCuts.sorted()
        var verticalCuts = verticalCuts.sorted()

        var mh = countMax(horizontalCuts, h)
        var mv = countMax(verticalCuts, w)

        return (mh*mv) % mod
    }

    func countMax(_ arr: [Int], _ total: Int) -> Int {
        let n = arr.count

        var maxCut = 0
        var cut = Array(repeating: 0, count: n+1)
        for i in 0..<n {
            cut[i] = i > 0 ? (arr[i]-arr[i-1]) : arr[i]
            cut[i+1] = total-arr[i]

            maxCut = max(maxCut, cut[i])
        }
        maxCut = max(maxCut, cut[n])

        // print(maxCut, cut)
        return maxCut
    }
}