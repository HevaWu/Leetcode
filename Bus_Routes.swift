// We have a list of bus routes. Each routes[i] is a bus route that the i-th bus repeats forever. For example if routes[0] = [1, 5, 7], this means that the first bus (0-th indexed) travels in the sequence 1->5->7->1->5->7->1->... forever.

// We start at bus stop S (initially not on a bus), and we want to go to bus stop T. Travelling by buses only, what is the least number of buses we must take to reach our destination? Return -1 if it is not possible.

// Example:
// Input: 
// routes = [[1, 2, 7], [3, 6, 7]]
// S = 1
// T = 6
// Output: 2
// Explanation: 
// The best strategy is take the first bus to the bus stop 7, then take the second bus to the bus stop 6.
// Note:

// 1 <= routes.length <= 500.
// 1 <= routes[i].length <= 500.
// 0 <= routes[i][j] < 10 ^ 6.

// Solution 1: BFS
// Instead of thinking of the stops as nodes (of a graph), think of the buses as nodes. We want to take the least number of buses, which is a shortest path problem, conducive to using a breadth-first search.
// 
// We perform a breadth first search on bus numbers. When we start at S, originally we might be able to board many buses, and if we end at T we may have many targets for our goal state.
// One difficulty is to efficiently decide whether two buses are connected by an edge. They are connected if they share at least one bus stop. Whether two lists share a common value can be done by set intersection (HashSet), or by sorting each list and using a two pointer approach.
// To make our search easy, we will annotate the depth of each node: info[0] = node, info[1] = depth.
// 
// Time Complexity: Let NN denote the number of buses, and b_ibe the number of stops on the iith bus.
// To create the graph, in Python we do O(\sum (N - i) b_i)work (we can improve this by checking for which of r1, r2 is smaller), while in Java we did a O(\sum b_i \log b_i)sorting step, plus our searches are O(N \sum b_i)work.
// Our (breadth-first) search is on NN nodes, and each node could have NN edges, so it is O(N^2).
// 
// Space Complexity: O(N^2 + \sum b_i)additional space complexity, the size of graph and routes. In Java, our space complexity is O(N^2)because we do not have an equivalent of routes. Dual-pivot quicksort (as used in Arrays.sort(int[])) is an in-place algorithm, so in Java we did not increase our space complexity by sorting.
class Solution {
    func numBusesToDestination(_ routes: [[Int]], _ S: Int, _ T: Int) -> Int {
        if S == T { return 0 }
        var routes = routes
        let n = routes.count
        
        var graph = Array(repeating: [Int](), count: n)
        for i in 0..<n {
            routes[i].sort()
        }
        
        // two buses are connected if they share at least one stop
        for i in 0..<n {
            for j in i+1..<n {
                if isConnected(routes[i], routes[j]) {
                    graph[i].append(j)
                    graph[j].append(i)
                }
            }
        }
        
        var queue = [(Int, Int)]()  // handle bfs
        var seens = Set<Int>()  // set of node have been enqueued in queue
        var targets = Set<Int>()  // set of goal state
        
        for i in 0..<n {
            if binarySearch(routes[i], S) >= 0 {
                seens.insert(i)
                queue.insert((i, 0), at: 0)
            }
            if binarySearch(routes[i], T) >= 0 {
                targets.insert(i)
            }
        }
                
        while !queue.isEmpty {
            var cur = queue.removeLast()
            let node = cur.0
            let depth = cur.1
            
            if targets.contains(node) {
                return depth + 1
            } 
            
            for next in graph[node] {
                if !seens.contains(next) {
                    seens.insert(next)
                    queue.insert((next, depth+1), at: 0)
                }
            }
        }
        return -1
    }
    
    func binarySearch(_ arr: [Int], _ target: Int) -> Int {
        var left = 0
        var right = arr.count-1
        while left < right {
            var mid = (left+right)/2
            if arr[mid] == target { return mid }
            if arr[mid] < target {
                left = mid + 1
            } else {
                right = mid
            }
        }
        return arr[left] == target ? left : -1
    }
    
    func isConnected(_ first: [Int], _ second: [Int]) -> Bool {
        var index1 = 0
        var index2 = 0
        while index1 < first.count, index2 < second.count {
            if first[index1] == second[index2] { return true }
            if first[index1] < second[index2] {
                index1 += 1
            } else {
                index2 += 1
            }
        }
        return false
    }
}