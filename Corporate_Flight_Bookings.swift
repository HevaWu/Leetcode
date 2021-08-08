/*
There are n flights that are labeled from 1 to n.

You are given an array of flight bookings bookings, where bookings[i] = [firsti, lasti, seatsi] represents a booking for flights firsti through lasti (inclusive) with seatsi seats reserved for each flight in the range.

Return an array answer of length n, where answer[i] is the total number of seats reserved for flight i.



Example 1:

Input: bookings = [[1,2,10],[2,3,20],[2,5,25]], n = 5
Output: [10,55,45,25,25]
Explanation:
Flight labels:        1   2   3   4   5
Booking 1 reserved:  10  10
Booking 2 reserved:      20  20
Booking 3 reserved:      25  25  25  25
Total seats:         10  55  45  25  25
Hence, answer = [10,55,45,25,25]
Example 2:

Input: bookings = [[1,2,10],[2,2,15]], n = 2
Output: [10,25]
Explanation:
Flight labels:        1   2
Booking 1 reserved:  10  10
Booking 2 reserved:      15
Total seats:         10  25
Hence, answer = [10,25]



Constraints:

1 <= n <= 2 * 104
1 <= bookings.length <= 2 * 104
bookings[i].length == 3
1 <= firsti <= lasti <= n
1 <= seatsi <= 104
*/

/*
Solution 2:
Since ranges are continuous, what if we add reservations to the first flight in the range, and remove them after the last flight in range? We can then use the running sum to update reservations for all flights.

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func corpFlightBookings(_ bookings: [[Int]], _ n: Int) -> [Int] {
        var flight = Array(repeating: 0, count: n)
        for b in bookings {
            flight[b[0]-1] += b[2]
            if b[1] < n {
                flight[b[1]] -= b[2]
            }
        }

        for i in 1..<n {
            flight[i] += flight[i-1]
        }
        return flight
    }
}

/*
Solution 1: TLE
*/
class Solution {
    func corpFlightBookings(_ bookings: [[Int]], _ n: Int) -> [Int] {
        var flight = Array(repeating: 0, count: n)
        for b in bookings {
            let first = b[0] - 1
            let last = b[1] - 1

            for f in first...last {
                flight[f] += b[2]
            }
        }
        return flight
    }
}