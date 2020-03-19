// In an election, the i-th vote was cast for persons[i] at time times[i].

// Now, we would like to implement the following query function: TopVotedCandidate.q(int t) will return the number of the person that was leading the election at time t.  

// Votes cast at time t will count towards our query.  In the case of a tie, the most recent vote (among tied candidates) wins.

 

// Example 1:

// Input: ["TopVotedCandidate","q","q","q","q","q","q"], [[[0,1,1,0,0,1,0],[0,5,10,15,20,25,30]],[3],[12],[25],[15],[24],[8]]
// Output: [null,0,1,1,0,0,1]
// Explanation: 
// At time 3, the votes are [0], and 0 is leading.
// At time 12, the votes are [0,1,1], and 1 is leading.
// At time 25, the votes are [0,1,1,0,0,1], and 1 is leading (as ties go to the most recent vote.)
// This continues for 3 more queries at time 15, 24, and 8.
 

// Note:

// 1 <= persons.length = times.length <= 5000
// 0 <= persons[i] <= persons.length
// times is a strictly increasing array with all elements in [0, 10^9].
// TopVotedCandidate.q is called at most 10000 times per test case.
// TopVotedCandidate.q(int t) is always called with t >= times[0].

// Solution 1: map + binary search
// As the votes come in, we can remember every event (winner, time) when the winner changes. After, we have a sorted list of these events that we can binary search for the answer.
// 
// Time Complexity: O(N + Q \log N)O(N+QlogN), where NN is the number of votes, and QQ is the number of queries.
// Space Complexity: O(N)O(N).
class TopVotedCandidate {
    var votes = [(winner: Int, time: Int)]()
    
    init(_ persons: [Int], _ times: [Int]) {
        // key is person, value is time
        var map = [Int: Int]()
        var leader = -1 // current leader
        var count = 0 // current leader votes
        
        for i in 0..<persons.count {
            let person = persons[i]
            let time = times[i]
            
            map[person, default: 0] += 1
            
            if map[person]! >= count {
                if person != leader {
                    leader = person
                    votes.append((leader, time))
                }
                
                count = max(count, map[person]!)
            }
        }
        print(votes)
    }
    
    func q(_ t: Int) -> Int {
        var left = 0
        var right = votes.count
        while left < right {
            var mid = (left+right)/2
            if votes[mid].time == t {
                return votes[mid].winner
            }
            
            if votes[mid].time < t {
                left = mid + 1
            } else {
                right = mid
            }
        }
        return left == 0 ? votes[left].winner : votes[left-1].winner
    }
}

/**
 * Your TopVotedCandidate object will be instantiated and called as such:
 * let obj = TopVotedCandidate(persons, times)
 * let ret_1: Int = obj.q(t)
 */