// Equations are given in the format A / B = k, where A and B are variables represented as strings, and k is a real number (floating point number). Given some queries, return the answers. If the answer does not exist, return -1.0.

// Example:
// Given a / b = 2.0, b / c = 3.0.
// queries are: a / c = ?, b / a = ?, a / e = ?, a / a = ?, x / x = ? .
// return [6.0, 0.5, -1.0, 1.0, -1.0 ].

// The input is: vector<pair<string, string>> equations, vector<double>& values, vector<pair<string, string>> queries , where equations.size() == values.size(), and the values are positive. This represents the equations. Return vector<double>.

// According to the example above:

// equations = [ ["a", "b"], ["b", "c"] ],
// values = [2.0, 3.0],
// queries = [ ["a", "c"], ["b", "a"], ["a", "e"], ["a", "a"], ["x", "x"] ]. 
 

// The input is always valid. You may assume that evaluating the queries will result in no division by zero and there is no contradiction.

// Solution 1: bfs
// according to equations and values, first build a map
// for each query, use 
// - queue <- for bfs
// - visited <- for checking the visited node
// - isfound <- mark if this already finded
// 
// Time complexity: O(n + nlogn) n is length of known node
// Space complexity: O(n(map) + answer lgn)
class Solution {
    func calcEquation(_ equations: [[String]], _ values: [Double], _ queries: [[String]]) -> [Double] {
        guard !queries.isEmpty else { return [Double]() }
        
        // put equation & value into map
        var map = [String: [(String, Double)]]()
        for (i, ivalue) in equations.enumerated() {
            if !map.keys.contains(ivalue[0]) {
                put(ivalue[0], ivalue[0], Double(1.0), &map)    
            }
            
            if !map.keys.contains(ivalue[1]) {
                put(ivalue[1], ivalue[1], Double(1.0), &map)    
            }
            
            put(ivalue[0], ivalue[1], values[i], &map)
            put(ivalue[1], ivalue[0], Double(1/values[i]), &map)
        }
        
        var ans = [Double]()
        for q in queries {
            guard map.keys.contains(q[0]), map.keys.contains(q[1]) else { 
                ans.append(-1.0)
                continue
            }
            
            // use bfs to find if there is direct answer
            var queue = [(String, Double)]()
            queue.insert((q[0], 1.0), at: 0)
            var visited = [String]()
            var isfound = false
            
            while !queue.isEmpty, !isfound {
                let node = queue.removeLast()
                
                guard !visited.contains(node.0) else { continue }
                visited.append(node.0)
                
                if let pair = map[node.0]!.first(where: { char, num in char == q[1] }) {
                    // finded answer
                    ans.append(node.1 * pair.1)
                    isfound = true
                    break
                }
                
                // not find, add adjacent node
                for next in map[node.0]! {
                    if next.0 != node.0 {
                        queue.insert((next.0, next.1 * node.1), at: 0)
                    }
                }
            }
            
            if !isfound {
                ans.append(Double(-1.0))
            }
        }
        return ans
    }
    
    func put(_ v1: String, _ v2: String, _ value: Double, _ map: inout [String: [(String, Double)]]) {
        if let _ = map[v1] {
            map[v1]!.append((v2, value))
        } else {
            map[v1] = [(v2, value)]
        }
    }
}