// Given an array of meeting time intervals consisting of start and end times [[s1,e1],[s2,e2],...] (si < ei), find the minimum number of conference rooms required.

// Example 1:

// Input: [[0, 30],[5, 10],[15, 20]]
// Output: 2
// Example 2:

// Input: [[7,10],[2,4]]
// Output: 1
// NOTE: input types have been changed on April 15, 2019. Please reset to default code definition to get new method signature.

// Hint
// Think about how we would approach this problem in a very simplistic way. We will allocate rooms to meetings that occur earlier in the day v/s the ones that occur later on, right?
// 
// If you've figured out that we have to sort the meetings by their start time, the next thing to think about is how do we do the allocation?
// There are two scenarios possible here for any meeting. Either there is no meeting room available and a new one has to be allocated, or a meeting room has freed up and this meeting can take place there.
// 
// An important thing to note is that we don't really care which room gets freed up while allocating a room for the current meeting. As long as a room is free, our job is done.
// We already know the rooms we have allocated till now and we also know when are they due to get free because of the end times of the meetings going on in those rooms. We can simply check the room which is due to get vacated the earliest amongst all the allocated rooms.

// Solution 1: sort & 
// Sort the intervals by start time, then check them one by one
// 
// Time Complexity: O(nlogn) sort + O(n)
// Space Complexity: O(k+n) k is room, n is interval
class Solution {
    func minMeetingRooms(_ intervals: [[Int]]) -> Int {
        guard !intervals.isEmpty else { return 0 }
        
        // sort by their start time
        var intervals = intervals.sorted { first, second in
            first[0] < second[0]
        }
        
        var room = [Int]()
        for interval in intervals {
            guard !room.isEmpty else {
                // add current interval endTime for marking
                room.append(interval[1])
                continue
            }
            
            // check exist room
            var i = 0
            while i < room.count {
                if room[i] <= interval[0] {
                    // update room[i]
                    room[i] = interval[1]
                    break
                } else {
                    i += 1
                }
            }
            
            if i == room.count {
                // no free room now, create a new one
                room.append(interval[1])
            }
        }
        
        return room.count
    }
}

// Solution 2: 2 pointer, start & end pointer
// Separate out the start times and the end times in their separate arrays.
// Sort the start times and the end times separately. Note that this will mess up the original correspondence of start times and end times. They will be treated individually now.
// We consider two pointers: s_ptr and e_ptr which refer to start pointer and end pointer. The start pointer simply iterates over all the meetings and the end pointer helps us track if a meeting has ended and if we can reuse a room.
// When considering a specific meeting pointed to by s_ptr, we check if this start timing is greater than the meeting pointed to by e_ptr. If this is the case then that would mean some meeting has ended by the time the meeting at s_ptr had to start. So we can reuse one of the rooms. Otherwise, we have to allocate a new room.
// If a meeting has indeed ended i.e. if start[s_ptr] >= end[e_ptr], then we increment e_ptr.
// Repeat this process until s_ptr processes all of the meetings.
// 
// Time Complexity: O(N\log N) because all we are doing is sorting the two arrays for start timings and end timings individually and each of them would contain NN elements considering there are NN intervals.
// Space Complexity: O(N) because we create two separate arrays of size NN, one for recording the start times and one for the end times.
class Solution {
    func minMeetingRooms(_ intervals: [[Int]]) -> Int {
        guard !intervals.isEmpty else { return 0 }
        
        var start = [Int]()
        var end = [Int]()
        for interval in intervals {
            start.append(interval[0])
            end.append(interval[1])
        }
        
        start.sort()
        end.sort()
        
        var room = 0
        var indexS = 0
        var indexE = 0
        while indexS < start.count {
            if start[indexS] < end[indexE] {
                // create new room
                room += 1
            } else {
                // have free room, use free room
                indexE += 1
            }
            indexS += 1
        }
        
        return room
    }
}