// Given a time represented in the format "HH:MM", form the next closest time by reusing the current digits. There is no limit on how many times a digit can be reused.

// You may assume the given input string is always valid. For example, "01:34", "12:09" are all valid. "1:34", "12:9" are all invalid.

// Example 1:

// Input: "19:34"
// Output: "19:39"
// Explanation: The next closest time choosing from digits 1, 9, 3, 4, is 19:39, which occurs 5 minutes later.  It is not 19:33, because this occurs 23 hours and 59 minutes later.
// Example 2:

// Input: "23:59"
// Output: "22:22"
// Explanation: The next closest time choosing from digits 2, 3, 5, 9, is 22:22. It may be assumed that the returned time is next day's time since it is smaller than the input time numerically.

// Solution 1:
// Simulate the clock going forward by one minute. Each time it moves forward, if all the digits are allowed, then return the current time.
// The natural way to represent the time is as an integer t in the range 0 <= t < 24 * 60. Then the hours are t / 60, the minutes are t % 60, and each digit of the hours and minutes can be found by hours / 10, hours % 10 etc.
// 
// Time Complexity: O(1)O(1). We try up to 24 * 6024∗60 possible times until we find the correct time.
// Space Complexity: O(1)O(1).
class Solution {
    func nextClosestTime(_ time: String) -> String {
        let first2 = String(time[time.startIndex..<time.firstIndex(of: ":")!])
        let last2 = String(time[time.index(after: time.firstIndex(of: ":")!)..<time.endIndex])
        var cur = Int(first2)! * 60 + Int(last2)!
        
        // put current digit into Set
        var timeSet = Set<Character>()
        for i in time {
            timeSet.insert(i)
        }
        
        // plus 1 minute and check if current one is the true result
        while true {
            cur = (cur + 1) % (24 * 60)
            var temp = String()
            for i in [cur / 60 / 10, cur / 60 % 10, cur % 60 / 10, cur % 60 % 10] {
                temp.append(String(i))
            }
            
            var nextTime: String? = {
                for i in temp {
                    guard timeSet.contains(i) else { return nil }
                }
                temp.insert(":", at: temp.index(temp.startIndex, offsetBy: 2))
                return temp
            }()
            
            if let nextTime = nextTime {
                return nextTime
            }
        }
    }
}

// Solution 2:
// We have up to 4 different allowed digits, which naively gives us 4 * 4 * 4 * 4 possible times. For each possible time, let's check that it can be displayed on a clock: ie., hours < 24 and mins < 60. The best possible time != start is the one with the smallest cand_elapsed = (time - start) % (24 * 60), as this represents the time that has elapsed since start, and where the modulo operation is taken to be always non-negative.
// For example, if we have start = 720 (ie. noon), then times like 12:05 = 725 means that (725 - 720) % (24 * 60) = 5 seconds have elapsed; while times like 00:10 = 10 means that (10 - 720) % (24 * 60) = -710 % (24 * 60) = 730 seconds have elapsed.
// Also, we should make sure to handle cand_elapsed carefully. When our current candidate time cur is equal to the given starting time, then cand_elapsed will be 0 and we should handle this case appropriately.
// 
// Note:
// Use let tempTime = (temp - cur) % (24 * 60) >= 0 ? (temp - cur) % (24 * 60) : (temp - cur) % (24 * 60) + (24 * 60)
// as the correct mod operator for negative element % 
// 
// Time Complexity: O(1). We all 4^4 possible times and take the best one.
// Space Complexity: O(1).
class Solution {
    func nextClosestTime(_ time: String) -> String {
        let first2 = time[time.startIndex..<time.firstIndex(of: ":")!]
        let last2 = time[time.index(after: time.firstIndex(of:":")!)..<time.endIndex]
        var cur = Int(first2)! * 60 + Int(last2)!
        
        // put all digit into a set
        var timeSet = Set<Int>()
        for i in time {
            if i != ":" {
                timeSet.insert(Int(String(i))!)   
            }
        }
        
        guard timeSet.count > 1 else { return time }
        
        var nextTime: Int?
        var shortestTime = 24 * 60
        // check all of possiblities in the set
        for h1 in timeSet {
            for h2 in timeSet {
                if h1 * 10 + h2 < 24 {
                    for m1 in timeSet {
                        for m2 in timeSet {
                            if m1 * 10 + m2 < 60 {
                                // calculate current time
                                let temp = (h1*10 + h2) * 60 + m1 * 10 + m2
                                let tempTime = (temp - cur) % (24 * 60) >= 0 
                                ? (temp - cur) % (24 * 60) 
                                : (temp - cur) % (24 * 60) + (24 * 60)
                                if tempTime > 0, tempTime < shortestTime {
                                    nextTime = temp
                                    shortestTime = tempTime   
                                }
                            }
                        }
                    }
                }
            }
        }
        return "\(nextTime! / 60 / 10)\(nextTime! / 60 % 10):\(nextTime! % 60 / 10)\(nextTime! % 60 % 10)"
    }
}