// There are N network nodes, labelled 1 to N.

// Given times, a list of travel times as directed edges times[i] = (u, v, w), where u is the source node, v is the target node, and w is the time it takes for a signal to travel from source to target.

// Now, we send a signal from a certain node K. How long will it take for all nodes to receive the signal? If it is impossible, return -1.

 

// Example 1:



// Input: times = [[2,1,1],[2,3,1],[3,4,1]], N = 4, K = 2
// Output: 2
 

// Note:

// N will be in the range [1, 100].
// K will be in the range [1, N].
// The length of times will be in the range [1, 6000].
// All edges times[i] = (u, v, w) will have 1 <= u, v <= N and 0 <= w <= 100.

// Solution 1: DFS
// map store the times info
// dist: store the shortest time which will take to reach this node
// 
// 1. store the times
// 2. sorted the map value list by the time
// 3. DFS
// 
// Time Complexity: O(N^N + E \log E) where EE is the length of times. We can only fully visit each node up to N-1N−1 times, one per each other node. Plus, we have to explore every edge and sort them. Sorting each small bucket of outgoing edges is bounded by sorting all of them, because of repeated use of the inequality x \log x + y \log y \leq (x+y) \log (x+y)xlogx+ylogy≤(x+y)log(x+y).
// Space Complexity: O(N + E)O(N+E), the size of the graph (O(E)O(E)), plus the size of the implicit call stack in our DFS (O(N)O(N)).
class Solution {
    // key is source 
    // value is list of (target, time)
    var map = [Int: [(Int, Int)]]()
    var dist = [Int: Int]()
    var time = 0
    
    func networkDelayTime(_ times: [[Int]], _ N: Int, _ K: Int) -> Int {
        for time in times {
            map[time[0], default: [(Int, Int)]()].append((time[1], time[2]))
        }
        
        // sort map value by time
        for time in map.keys {
            map[time] = map[time]?.sorted(by: { first, second -> Bool in
                return first.1 < second.1
            })
        }
        
        countTime(from: K, currTime: 0)
        if dist.keys.count < N { return -1 }
        for k in dist.keys {
            time = max(time, dist[k]!)
        }
        return time
    }
    
    func countTime(from node: Int, currTime: Int) {
        if currTime >= dist[node, default: Int.max] { return }
        dist[node] = currTime
        
        if let list = map[node] {
            for l in list {
                countTime(from: l.0, currTime: l.1 + currTime)
            }
        }
    }
}

// Solution 2: Dijkstra's
// 
// Time Complexity: O(N^2 + E) where EE is the length of times in the basic implementation, and O(E \log E)O(ElogE) in the heap implementation, as potentially every edge gets added to the heap.
// Space Complexity: O(N + E)O(N+E), the size of the graph (O(E)O(E)), plus the size of the other objects used (O(N)O(N)).
class Solution {
    func networkDelayTime(_ times: [[Int]], _ N: Int, _ K: Int) -> Int {
        var map = [Int: [(Int, Int)]]()
        for time in times {
            map[time[0], default: [(Int, Int)]()].append((time[1], time[2]))
        }
        
        var dist = [Int: Int]()
        for i in 1...N {
            dist[i] = Int.max
        }
        dist[K] = 0
        
        var visited = Array(repeating: false, count: N+1)
        
        while true {
            var node = -1
            var tempDist = Int.max
            for i in 1...N {
                if !visited[i] && dist[i]! < tempDist {
                    tempDist = dist[i]!
                    node = i
                }
            }
            
            if node < 0 { break }
            
            visited[node] = true
            if let list = map[node] {
                for l in list {
                    dist[l.0] = min(dist[l.0]!, dist[node]! + l.1)
                }   
            }
        }
        
        var time = 0
        for i in dist.values {
            if i == Int.max { return -1 }
            time = max(time, i)
        }
        return time
    }
}

// Solution 3:
// Same as Solution 2, use heap / priorityQueue
// in swift we could achieve it by Dictionary, but we need to add our own code on it.