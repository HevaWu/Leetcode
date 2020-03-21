// You have a lock in front of you with 4 circular wheels. Each wheel has 10 slots: '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'. The wheels can rotate freely and wrap around: for example we can turn '9' to be '0', or '0' to be '9'. Each move consists of turning one wheel one slot.

// The lock initially starts at '0000', a string representing the state of the 4 wheels.

// You are given a list of deadends dead ends, meaning if the lock displays any of these codes, the wheels of the lock will stop turning and you will be unable to open it.

// Given a target representing the value of the wheels that will unlock the lock, return the minimum total number of turns required to open the lock, or -1 if it is impossible.

// Example 1:
// Input: deadends = ["0201","0101","0102","1212","2002"], target = "0202"
// Output: 6
// Explanation:
// A sequence of valid moves would be "0000" -> "1000" -> "1100" -> "1200" -> "1201" -> "1202" -> "0202".
// Note that a sequence like "0000" -> "0001" -> "0002" -> "0102" -> "0202" would be invalid,
// because the wheels of the lock become stuck after the display becomes the dead end "0102".
// Example 2:
// Input: deadends = ["8888"], target = "0009"
// Output: 1
// Explanation:
// We can turn the last wheel in reverse to move from "0000" -> "0009".
// Example 3:
// Input: deadends = ["8887","8889","8878","8898","8788","8988","7888","9888"], target = "8888"
// Output: -1
// Explanation:
// We can't reach the target without getting stuck.
// Example 4:
// Input: deadends = ["0000"], target = "8888"
// Output: -1
// Note:
// The length of deadends will be in the range [1, 500].
// target will not be in the list deadends.
// Every string in deadends and the string target will be a string of 4 digits from the 10,000 possibilities '0000' to '9999'.

// Solution 1: BFS
// We can think of this problem as a shortest path problem on a graph: there are 10000 nodes (strings '0000' to '9999'), and there is an edge between two nodes if they differ in one digit, that digit differs by 1 (wrapping around, so '0' and '9' differ by 1), and if both nodes are not in deadends.
// 
// To solve a shortest path problem, we use a breadth-first search. The basic structure uses a Queue queue plus a Set seen that records if a node has ever been enqueued. This pushes all the work to the neighbors function - in our Python implementation, all the code after while queue: is template code, except for if node in dead: continue.
// As for the neighbors function, for each position in the lock i = 0, 1, 2, 3, for each of the turns d = -1, 1, we determine the value of the lock after the i-th wheel has been turned in the direction d.
// Care should be taken in our algorithm, as the graph does not have an edge unless both nodes are not in deadends. If our neighbors function checks only the target for being in deadends, we also need to check whether '0000' is in deadends at the beginning. In our implementation, we check at the visitor level so as to neatly handle this problem in all cases.
// In Java, our implementation also inlines the neighbors function for convenience, and uses null inputs in the queue to represent a layer change. When the layer changes, we depth++ our global counter, and queue.peek() != null checks if there are still nodes enqueued.
// 
// Time Complexity: O(N^2 * \mathcal{A}^N + D)where \mathcal{A}A is the number of digits in our alphabet, NN is the number of digits in the lock, and DD is the size of deadends. We might visit every lock combination, plus we need to instantiate our set dead. When we visit every lock combination, we spend O(N^2)time enumerating through and constructing each node.
// Space Complexity: O(\mathcal{A}^N + D), for the queue and the set dead.
class Solution {
    func openLock(_ deadends: [String], _ target: String) -> Int {
        guard !deadends.contains("0000") else { return -1 }
        var deadends = Set(deadends)
        
        var queue = ["0000"]
        var visited = Set(["0000"])
        var move = 0
        
        while !queue.isEmpty {
            var count = queue.count
            while count > 0 {
                var curr = queue.removeLast()

                if curr == target {
                    return move
                }

                if deadends.contains(curr) {
                    // lock
                    count -= 1
                    continue
                }

                for i in curr.indices {
                    for j in [-1, 1] {
                        var temp = (curr[i].wholeNumberValue! + j + 10) % 10
                        var next = curr
                        next.remove(at: i)
                        next.insert(String(temp).first!, at: i)
                        if !visited.contains(next) {
                            visited.insert(next)
                            queue.insert(next, at: 0)
                        }
                    }
                }
                
                count -= 1
            }
            move += 1
        }
        return -1
    }
}

// Solution 2: begin & end two side
// begin: always start from the shorter one
// end: 
// 
// Time complexity : O ()
class Solution {
    func openLock(_ deadends: [String], _ target: String) -> Int {
        var deadends = Set(deadends)
        guard !deadends.contains("0000") else { return -1 }
        
        var begin = Set(["0000"])
        var end = Set([target])
        var temp = Set<String>()
        
        var move = 0
        
        while !begin.isEmpty, !end.isEmpty {
            // always keep begin shorter than end
            if begin.count > end.count {
                temp = begin
                begin = end
                end = temp
            }
            temp = Set<String>()
            
            for s in begin {
                if end.contains(s) { return move }
                if deadends.contains(s) { continue }
                deadends.insert(s)
                
                for i in s.indices {
                    for j in [-1, 1] {
                        // + 10 to avoid -1 value
                        var num = (s[i].wholeNumberValue! + j + 10) % 10
                        var next = s
                        next.remove(at: i)
                        next.insert(String(num).first!, at: i)
                        
                        if !deadends.contains(next) {
                            temp.insert(next)
                        }
                    }
                }
            }
            move += 1
            begin = temp
        }
        return -1
    }
}