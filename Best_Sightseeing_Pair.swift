/*
You are given an integer array values where values[i] represents the value of the ith sightseeing spot. Two sightseeing spots i and j have a distance j - i between them.

The score of a pair (i < j) of sightseeing spots is values[i] + values[j] + i - j: the sum of the values of the sightseeing spots, minus the distance between them.

Return the maximum score of a pair of sightseeing spots.



Example 1:

Input: values = [8,1,5,2,6]
Output: 11
Explanation: i = 0, j = 2, values[i] + values[j] + i - j = 8 + 5 + 0 - 2 = 11
Example 2:

Input: values = [1,2]
Output: 2


Constraints:

2 <= values.length <= 5 * 104
1 <= values[i] <= 1000

*/

/*
Soluton 2:

iterate once

Count the current best score in all previous sightseeing spot.
Note that, as we go further, the score of previous spot decrement.

cur will record the best score that we have met.
We iterate each value a in the array A,
update res by max(res, cur + a)

Also we can update cur by max(cur, a).
Note that when we move forward,
all sightseeing spot we have seen will be 1 distance further.

So for the next sightseeing spot cur = Math.max(cur, a) - 1

There is a feeling that,
"A near neighbor is better than a distant cousin."

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func maxScoreSightseeingPair(_ values: [Int]) -> Int {
        var cur = 0
        var res = 0
        for v in values {
            res = max(res, cur + v)
            // all sightseeing spot will be 1 distance furthre
            cur = max(cur, v) - 1
        }
        return res
    }
}

/*
Solution 1:
TLE
*/
class Solution {
    func maxScoreSightseeingPair(_ values: [Int]) -> Int {
        let n = values.count

        var score = 0
        for i in 0..<(n-1) {
            for j in (i+1)..<n {
                score = max(score, values[i] + values[j] - (j-i) )
            }
        }
        return score
    }
}