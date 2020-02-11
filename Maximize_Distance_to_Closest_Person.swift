// In a row of seats, 1 represents a person sitting in that seat, and 0 represents that the seat is empty. 

// There is at least one empty seat, and at least one person sitting.

// Alex wants to sit in the seat such that the distance between him and the closest person to him is maximized. 

// Return that maximum distance to closest person.

// Example 1:

// Input: [1,0,0,0,1,0,1]
// Output: 2
// Explanation: 
// If Alex sits in the second open seat (seats[2]), then the closest person has distance 2.
// If Alex sits in any other open seat, the closest person has distance 1.
// Thus, the maximum distance to the closest person is 2.
// Example 2:

// Input: [1,0,0,0]
// Output: 3
// Explanation: 
// If Alex sits in the last seat, the closest person is 3 seats away.
// This is the maximum distance possible, so the answer is 3.
// Note:

// 1 <= seats.length <= 20000
// seats contains only 0s or 1s, at least one 0, and at least one 1.

// Solution 1: 
// use array to store value is 1 index
// set init dis as arr[0] since first one should be the first 1 to 0 index
// go through this array to help finding the largest dis
// 
// Time Complexity: O(2n)
// Space Complexity: O(n)
class Solution {
    func maxDistToClosest(_ seats: [Int]) -> Int {
        var sitArr = [Int]()
        for (index, value) in seats.enumerated() {
            if value == 1 { 
                sitArr.append(index)
            }
        }

        let n = seats.count
        var pre = 0
        var dis = sitArr[0]
        
        for i in 0..<sitArr.count {
            dis = max((sitArr[i] - pre) / 2, dis)
            pre = sitArr[i]
        }
        
        dis = max(dis, seats.count - 1 - sitArr[sitArr.count - 1])

        return dis
    }
}

// Solution 2:
// For optimizing, directly go through seats 1 time.
// by marking the pre pointer would be enough
// 
// Time complexity: O(n)
// Space complexity: O(1)
class Solution {
    func maxDistToClosest(_ seats: [Int]) -> Int {
        let first = seats.firstIndex(of: 1)!
        var dis = first
        var pre = first
        
        var i = first + 1
        var next = i
        while i < seats.count {
            // find next 1
            next = i
            while next < seats.count {
                if seats[next] == 0 { 
                    next += 1
                    continue 
                }
                dis = max(dis, (next - pre) / 2)
                pre = next
                break
            }
            i = next + 1
        }
        
        // check if last one is 0
        if next == seats.count {
            dis = max(dis, next - pre - 1)    
        }
        return dis
    }
}