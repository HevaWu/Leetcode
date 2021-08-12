/*
There is a party where n friends numbered from 0 to n - 1 are attending. There is an infinite number of chairs in this party that are numbered from 0 to infinity. When a friend arrives at the party, they sit on the unoccupied chair with the smallest number.

For example, if chairs 0, 1, and 5 are occupied when a friend comes, they will sit on chair number 2.
When a friend leaves the party, their chair becomes unoccupied at the moment they leave. If another friend arrives at that same moment, they can sit in that chair.

You are given a 0-indexed 2D integer array times where times[i] = [arrivali, leavingi], indicating the arrival and leaving times of the ith friend respectively, and an integer targetFriend. All arrival times are distinct.

Return the chair number that the friend numbered targetFriend will sit on.



Example 1:

Input: times = [[1,4],[2,3],[4,6]], targetFriend = 1
Output: 1
Explanation:
- Friend 0 arrives at time 1 and sits on chair 0.
- Friend 1 arrives at time 2 and sits on chair 1.
- Friend 1 leaves at time 3 and chair 1 becomes empty.
- Friend 0 leaves at time 4 and chair 0 becomes empty.
- Friend 2 arrives at time 4 and sits on chair 0.
Since friend 1 sat on chair 1, we return 1.
Example 2:

Input: times = [[3,10],[1,5],[2,6]], targetFriend = 0
Output: 2
Explanation:
- Friend 1 arrives at time 1 and sits on chair 0.
- Friend 2 arrives at time 2 and sits on chair 1.
- Friend 0 arrives at time 3 and sits on chair 2.
- Friend 1 leaves at time 5 and chair 0 becomes empty.
- Friend 2 leaves at time 6 and chair 1 becomes empty.
- Friend 0 leaves at time 10 and chair 2 becomes empty.
Since friend 0 sat on chair 2, we return 2.


Constraints:

n == times.length
2 <= n <= 104
times[i].length == 2
1 <= arrivali < leavingi <= 105
0 <= targetFriend <= n - 1
Each arrivali time is distinct.
*/

/*
Solution 1:
binary search (priority queue)

arrive is distinct, mark targetArrive

1. sort times by arrival times
2. for each t,
=> check if there is any person leave their seat, if so, put their leaved seat into [seat] array
=> if current seat array is empty, means all seat has token, increase token, let t person seat in this token seat
=> if current seat array is NOT empty, means there is some previous person leaved empty seat, let this t person seat at the "smallest" index seat
=> put this person into occupied(leave, seat) to record this person is seat right now

Time Complexity: O(nlogn + n^2)
- times.count = n
Space Complexity: O(n)
*/
class Solution {
    func smallestChair(_ times: [[Int]], _ targetFriend: Int) -> Int {
        var targetArrive = times[targetFriend][0]

        // sort by arrival time
        var times = times.sorted(by: { first, second in
            return first[0] < second[0]
        })
        // print(times)

        // sorted by leaveTime array
        var occupied = [(leave: Int, seat: Int)]()
        // sorted by seat number
        var seat = [Int]()

        // token keep increasing seat numbers monotonically from 0..n
        var token = 0
        for t in times {
            let arrive = t[0]
            let leave = t[1]

            while !occupied.isEmpty, occupied.first!.leave <= arrive {
                insert(occupied.removeFirst().seat, &seat)
            }

            var curSeat = 0
            if !seat.isEmpty {
                curSeat = seat.removeFirst()
            } else {
                curSeat = token
                token += 1
            }

            if arrive == targetArrive {
                return curSeat
            }
            insertOccupies((leave, curSeat), &occupied)
        }

        return 0
    }

    func insert(_ target: Int, _ seat: inout [Int]) {
        if seat.isEmpty {
            seat.append(target)
            return
        }

        var left = 0
        var right = seat.count-1
        while left < right {
            let mid = left + (right-left)/2
            if seat[mid] < target {
                left = mid+1
            } else {
                right = mid
            }
        }
        seat.insert(target, at: seat[left] < target ? left+1 : right)
    }

    func insertOccupies(_ target: (leave: Int, seat: Int),
                        _ occupied: inout [(leave: Int, seat: Int)]) {
        if occupied.isEmpty {
            occupied.append(target)
            return
        }

        var left = 0
        var right = occupied.count-1
        while left < right {
            let mid = left + (right - left)/2
            if occupied[mid].leave < target.leave {
                left = mid+1
            } else {
                right = mid
            }
        }

        occupied.insert(target, at: occupied[left].leave < target.leave ? left+1 : left)
    }
}