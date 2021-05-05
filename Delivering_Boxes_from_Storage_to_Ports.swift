/*
You have the task of delivering some boxes from storage to their ports using only one ship. However, this ship has a limit on the number of boxes and the total weight that it can carry.

You are given an array boxes, where boxes[i] = [ports​​i​, weighti], and three integers portsCount, maxBoxes, and maxWeight.

ports​​i is the port where you need to deliver the ith box and weightsi is the weight of the ith box.
portsCount is the number of ports.
maxBoxes and maxWeight are the respective box and weight limits of the ship.
The boxes need to be delivered in the order they are given. The ship will follow these steps:

The ship will take some number of boxes from the boxes queue, not violating the maxBoxes and maxWeight constraints.
For each loaded box in order, the ship will make a trip to the port the box needs to be delivered to and deliver it. If the ship is already at the correct port, no trip is needed, and the box can immediately be delivered.
The ship then makes a return trip to storage to take more boxes from the queue.
The ship must end at storage after all the boxes have been delivered.

Return the minimum number of trips the ship needs to make to deliver all boxes to their respective ports.



Example 1:

Input: boxes = [[1,1],[2,1],[1,1]], portsCount = 2, maxBoxes = 3, maxWeight = 3
Output: 4
Explanation: The optimal strategy is as follows:
- The ship takes all the boxes in the queue, goes to port 1, then port 2, then port 1 again, then returns to storage. 4 trips.
So the total number of trips is 4.
Note that the first and third boxes cannot be delivered together because the boxes need to be delivered in order (i.e. the second box needs to be delivered at port 2 before the third box).
Example 2:

Input: boxes = [[1,2],[3,3],[3,1],[3,1],[2,4]], portsCount = 3, maxBoxes = 3, maxWeight = 6
Output: 6
Explanation: The optimal strategy is as follows:
- The ship takes the first box, goes to port 1, then returns to storage. 2 trips.
- The ship takes the second, third and fourth boxes, goes to port 3, then returns to storage. 2 trips.
- The ship takes the fifth box, goes to port 3, then returns to storage. 2 trips.
So the total number of trips is 2 + 2 + 2 = 6.
Example 3:

Input: boxes = [[1,4],[1,2],[2,1],[2,1],[3,2],[3,4]], portsCount = 3, maxBoxes = 6, maxWeight = 7
Output: 6
Explanation: The optimal strategy is as follows:
- The ship takes the first and second boxes, goes to port 1, then returns to storage. 2 trips.
- The ship takes the third and fourth boxes, goes to port 2, then returns to storage. 2 trips.
- The ship takes the fifth and sixth boxes, goes to port 3, then returns to storage. 2 trips.
So the total number of trips is 2 + 2 + 2 = 6.
Example 4:

Input: boxes = [[2,4],[2,5],[3,1],[3,2],[3,7],[3,1],[4,4],[1,3],[5,2]], portsCount = 5, maxBoxes = 5, maxWeight = 7
Output: 14
Explanation: The optimal strategy is as follows:
- The ship takes the first box, goes to port 2, then storage. 2 trips.
- The ship takes the second box, goes to port 2, then storage. 2 trips.
- The ship takes the third and fourth boxes, goes to port 3, then storage. 2 trips.
- The ship takes the fifth box, goes to port 3, then storage. 2 trips.
- The ship takes the sixth and seventh boxes, goes to port 3, then port 4, then storage. 3 trips.
- The ship takes the eighth and ninth boxes, goes to port 1, then port 5, then storage. 3 trips.
So the total number of trips is 2 + 2 + 2 + 2 + 3 + 3 = 14.


Constraints:

1 <= boxes.length <= 105
1 <= portsCount, maxBoxes, maxWeight <= 105
1 <= ports​​i <= portsCount
1 <= weightsi <= maxWeight
*/

/*
Solution 2:
DP + sliding window

use left, right pointer
without extra diff space

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func boxDelivering(_ boxes: [[Int]], _ portsCount: Int, _ maxBoxes: Int, _ maxWeight: Int) -> Int {
        let n = boxes.count
        var dp = Array(repeating: 200000, count: n+1)
        dp[0] = 0

        var diff = 0
        var right = 0
        var last = 0

        var remainBox = maxBoxes
        var remainWeight = maxWeight

        for i in 0..<n {
            // keep expanding right
            while right < n, remainBox > 0, remainWeight >= boxes[right][1] {
                remainBox -= 1
                remainWeight -= boxes[right][1]
                if right == 0 || boxes[right][0] != boxes[right-1][0] {
                    // 2 ports are different
                    last = right
                    diff += 1
                }
                right += 1
            }

            // keep load as far as right as we can
            dp[right] = min(dp[right], dp[i]+diff+1)

            // waste some weight to save trip
            dp[last] = min(dp[last], dp[i]+diff)

            // move left pointer i
            remainBox += 1
            remainWeight += boxes[i][1]

            // if current box port is different with previous one, reduce diff
            if i == n-1 || boxes[i][0] != boxes[i+1][0] {
                diff -= 1
            }
        }

        return dp[n]
    }
}

/*
Solution 1:
DP + sliding window

dp[i+1] be the minimum cost (# of ships) to process all boxes from 0 to i and return to the storage.

- we need to find the best position start where we can load up all boxes from start to i and then go in a single voyage, then dp[i+1] = dp[start] + something.
- sliding window to find start
    - limit # of boxes in 1 voyage
    - limit total weight in 1 voyage
    - No benefit to load the box at position start (i.e dp[start] == dp[start+1]), because the cost to keep the box on the ship is at most 1. (More explanation for Policy 3 at the end of the post).
        - In fact, every j from start onward (after applying 3 policies above) have the following properties:
        - (a) The cost to keep the box j on the ship is 0 if A[j][0] = A[j+1][0] (i.e. same ports), and is 1 if A[j][0] != A[j+1][0].
        - (b) if A[j][0] != A[j+1][0] then dp[j + 2] > dp[j+1].
        - This means that if we drop box j and save 1 cost thanks to Observation (a), we have to pay it back 1 step later if we continue to drop box j+1 thanks to Observation (b). Now you say "yay, if I drop j but don't drop j+1, then I save 1 cost". But indeed we already pay upfront 1 cost for nothing because we drop start some moment ago. So all in all, we never save cost by continuing dropping boxes after satisfying all 3 policies above. This is why we stop dropping when dp[start + 1] > dp[start].

Time Complexity: O(n*n)
Space Complexity: O(n)
*/
class Solution {
    func boxDelivering(_ boxes: [[Int]], _ portsCount: Int, _ maxBoxes: Int, _ maxWeight: Int) -> Int {
        let n = boxes.count
        var dp = Array(repeating: 0, count: n+1)

        // record consecutive ports are different or not
        var diffPorts = Array(repeating: false, count: n)
        for i in 1..<n {
            if boxes[i-1][0] != boxes[i][0] {
                diffPorts[i-1] = true
            }
        }

        var curWeight = 0
        var start = 0

        // different consecutive ports between start to i
        var diff = 0

        for i in 0..<n {
            if i-start == maxBoxes {
                // out of box limit, drop 1 box
                curWeight -= boxes[start][1]
                if diffPorts[start] { diff -= 1 }
                start += 1
            }

            // take box i, update weight and diff
            curWeight += boxes[i][1]
            if i > 0, diffPorts[i-1] { diff += 1 }

            // drop more boxes if weight out of limit
            while curWeight > maxWeight {
                curWeight -= boxes[start][1]
                if diffPorts[start] { diff -= 1 }
                start += 1
            }

            // drop more boxes if there is no benefits to carry them
            while start < i, dp[start] == dp[start + 1] {
                curWeight -= boxes[start][1]
                if diffPorts[start] { diff -= 1 }
                start += 1
            }

            dp[i+1] = diff+2 + dp[start]
        }

        return dp[n]
    }
}