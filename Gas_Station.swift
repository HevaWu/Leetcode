/*
There are n gas stations along a circular route, where the amount of gas at the ith station is gas[i].

You have a car with an unlimited gas tank and it costs cost[i] of gas to travel from the ith station to its next (i + 1)th station. You begin the journey with an empty tank at one of the gas stations.

Given two integer arrays gas and cost, return the starting gas station's index if you can travel around the circuit once in the clockwise direction, otherwise return -1. If there exists a solution, it is guaranteed to be unique

 

Example 1:

Input: gas = [1,2,3,4,5], cost = [3,4,5,1,2]
Output: 3
Explanation:
Start at station 3 (index 3) and fill up with 4 unit of gas. Your tank = 0 + 4 = 4
Travel to station 4. Your tank = 4 - 1 + 5 = 8
Travel to station 0. Your tank = 8 - 2 + 1 = 7
Travel to station 1. Your tank = 7 - 3 + 2 = 6
Travel to station 2. Your tank = 6 - 4 + 3 = 5
Travel to station 3. The cost is 5. Your gas is just enough to travel back to station 3.
Therefore, return 3 as the starting index.
Example 2:

Input: gas = [2,3,4], cost = [3,4,3]
Output: -1
Explanation:
You can't start at station 0 or 1, as there is not enough gas to travel to the next station.
Let's start at station 2 and fill up with 4 unit of gas. Your tank = 0 + 4 = 4
Travel to station 0. Your tank = 4 - 3 + 2 = 3
Travel to station 1. Your tank = 3 - 3 + 3 = 3
You cannot travel back to station 2, as it requires 4 unit of gas but you only have 3.
Therefore, you can't travel around the circuit once no matter where you start.
 

Constraints:

gas.length == n
cost.length == n
1 <= n <= 104
0 <= gas[i], cost[i] <= 104
*/

/*
Solution 3:
space optimization

use total to memo all negative cost
use tank to memo all positive cost

in the end, if total+tank >= 0, then this start is valid

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
        var total = 0
        var tank = 0
        
        var start = 0
        
        for i in 0..<gas.count {
            tank += gas[i]-cost[i]
            if tank < 0 {
                total += tank
                start = i + 1
                tank = 0
            }
        }
        return total+tank < 0 ? -1 : start
    }
}

/*
Solution 2:
- iterate array, cache diff of gas[i] - cost[i]
- find min(most negative tank cost), according to it, set startIndex = i+1
- check if this startIndex can complete circle, if not, return -1

Time Complexity:O(n)
Space Complexity: O(n)
*/
class Solution {
    func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
        let n = gas.count
        
        var cache = Array(repeating: 0, count: n)
        var tank = 0
        var min = 0
        var startIndex = 0
        for i in 0..<n {
            cache[i] = gas[i] - cost[i]
            tank += cache[i]
            if tank < min {
                min = tank
                startIndex = i+1
            }
        }
        
        tank = 0
        for i in startIndex..<(n+startIndex) {
            tank += cache[i%n]
            if tank < 0 {
                return -1
            }
        }
        return startIndex
    }
}

/*
Solution 1:
check if we can start from i station

Time Complexity: O(n^2)
Space Complexity: O(1)
*/
class Solution {
    func canCompleteCircuit(_ gas: [Int], _ cost: [Int]) -> Int {
        let n = gas.count
        
        for i in 0..<n {
            if canComplete(i, n, gas, cost) {
                return i
            }
        }
        return -1
    }
    
    func canComplete(_ start: Int, _ n: Int, 
                    _ gas: [Int], _ cost: [Int]) -> Bool {
        var cur = start
        var tank = 0
        while true {
            tank += (gas[cur] - cost[cur])
            if tank < 0 {
                return false
            }

            cur = (cur+1 == n ? 0 : cur+1)
            if cur == start {
                break
            }
        }
        return true
    }
}