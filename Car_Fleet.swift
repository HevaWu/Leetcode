// N cars are going to the same destination along a one lane road.  The destination is target miles away.

// Each car i has a constant speed speed[i] (in miles per hour), and initial position position[i] miles towards the target along the road.

// A car can never pass another car ahead of it, but it can catch up to it, and drive bumper to bumper at the same speed.

// The distance between these two cars is ignored - they are assumed to have the same position.

// A car fleet is some non-empty set of cars driving at the same position and same speed.  Note that a single car is also a car fleet.

// If a car catches up to a car fleet right at the destination point, it will still be considered as one car fleet.


// How many car fleets will arrive at the destination?

 

// Example 1:

// Input: target = 12, position = [10,8,0,5,3], speed = [2,4,1,1,3]
// Output: 3
// Explanation:
// The cars starting at 10 and 8 become a fleet, meeting each other at 12.
// The car starting at 0 doesn't catch up to any other car, so it is a fleet by itself.
// The cars starting at 5 and 3 become a fleet, meeting each other at 6.
// Note that no other cars meet these fleets before the destination, so the answer is 3.

// Note:

// 0 <= N <= 10 ^ 4
// 0 < target <= 10 ^ 6
// 0 < speed[i] <= 10 ^ 6
// 0 <= position[i] < target
// All initial positions are different.

// Solution 1: sort
// A car is a (position, speed) which implies some arrival time (target - position) / speed. Sort the cars by position.
// Now apply the above reasoning - if the lead fleet drives away, then count it and continue. Otherwise, merge the fleets and continue.
// 
// Time complexity: O(nlogn)
// Space complexity: O(n)
class Solution {
    func carFleet(_ target: Int, _ position: [Int], _ speed: [Int]) -> Int {
        guard !position.isEmpty, !speed.isEmpty else { return 0 }
        let n = position.count
        
        // position, time
        var pair = [(Int, Double)]()
        for i in 0..<n {
            pair.append((position[i], Double(target - position[i]) / Double(speed[i])))
        }
        
        // sort according to position
        pair.sort(by: { first, second -> Bool in
            return first.0 < second.0
        })
        
        var fleet = 0
        var i = n-1
        while i > 0 {
            if pair[i].1 < pair[i-1].1 {
                // i arrive faster, cannot be catch
                fleet += 1
            } else {
                // i-1 arrives as the same time as i
                pair[i-1] = pair[i]
            }
            i -= 1
        }
        
        return fleet + 1
    }
}