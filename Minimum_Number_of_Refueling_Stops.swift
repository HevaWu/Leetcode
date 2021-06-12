/*
A car travels from a starting position to a destination which is target miles east of the starting position.

Along the way, there are gas stations.  Each station[i] represents a gas station that is station[i][0] miles east of the starting position, and has station[i][1] liters of gas.

The car starts with an infinite tank of gas, which initially has startFuel liters of fuel in it.  It uses 1 liter of gas per 1 mile that it drives.

When the car reaches a gas station, it may stop and refuel, transferring all the gas from the station into the car.

What is the least number of refueling stops the car must make in order to reach its destination?  If it cannot reach the destination, return -1.

Note that if the car reaches a gas station with 0 fuel left, the car can still refuel there.  If the car reaches the destination with 0 fuel left, it is still considered to have arrived.



Example 1:

Input: target = 1, startFuel = 1, stations = []
Output: 0
Explanation: We can reach the target without refueling.
Example 2:

Input: target = 100, startFuel = 1, stations = [[10,100]]
Output: -1
Explanation: We can't reach the target (or even the first gas station).
Example 3:

Input: target = 100, startFuel = 10, stations = [[10,60],[20,30],[30,30],[60,40]]
Output: 2
Explanation:
We start with 10 liters of fuel.
We drive to position 10, expending 10 liters of fuel.  We refuel from 0 liters to 60 liters of gas.
Then, we drive from position 10 to position 60 (expending 50 liters of fuel),
and refuel from 10 liters to 50 liters of gas.  We then drive to and reach the target.
We made 2 refueling stops along the way, so we return 2.


Note:

1 <= target, startFuel, stations[i][1] <= 10^9
0 <= stations.length <= 500
0 < stations[0][0] < stations[1][0] < ... < stations[stations.length-1][0] < target
*/

/*
Solution 1:
DP

Let's determine dp[i], the farthest location we can get to using i refueling stops. This is motivated by the fact that we want the smallest i for which dp[i] >= target.

Let's update dp as we consider each station in order. With no stations, clearly we can get a maximum distance of startFuel with 0 refueling stops.

Now let's look at the update step. When adding a station station[i] = (location, capacity), any time we could reach this station with t refueling stops, we can now reach capacity further with t+1 refueling stops.

For example, if we could reach a distance of 15 with 1 refueling stop, and now we added a station at location 10 with 30 liters of fuel, then we could potentially reach a distance of 45 with 2 refueling stops.

Time Complexity: O(n^2)
Space Complexity: O(n)
*/
class Solution {
    func minRefuelStops(_ target: Int, _ startFuel: Int, _ stations: [[Int]]) -> Int {
        let n = stations.count

        // without re-fuel, use initial startFuel is enough
        if startFuel >= target { return 0 }

        // dp[i], farthest location to use i refueling stops
        var dp = Array(repeating: 0, count: n+1)
        dp[0] = startFuel

        for i in 0..<n {
            for j in stride(from: i, through: 0, by: -1) {
                if dp[j] >= stations[i][0] {
                    dp[j+1] = max(dp[j+1], dp[j]+stations[i][1])
                }
            }
        }

        // use 0...n
        for i in 0...n {
            if dp[i] >= target { return i }
        }
        return -1
    }
}