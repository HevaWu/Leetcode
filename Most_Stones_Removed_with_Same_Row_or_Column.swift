// On a 2D plane, we place stones at some integer coordinate points.  Each coordinate point may have at most one stone.

// Now, a move consists of removing a stone that shares a column or row with another stone on the grid.

// What is the largest possible number of moves we can make?

 

// Example 1:

// Input: stones = [[0,0],[0,1],[1,0],[1,2],[2,1],[2,2]]
// Output: 5
// Example 2:

// Input: stones = [[0,0],[0,2],[1,1],[2,0],[2,2]]
// Output: 3
// Example 3:

// Input: stones = [[0,0]]
// Output: 0
 

// Note:

// 1 <= stones.length <= 1000
// 0 <= stones[i][j] < 10000

// Solution 1: DFS
// For every stone not yet visited, we will visit it and any stone in the same connected component. Our depth-first search traverses each node in the component.
// For each component, the answer changes by -1 + component.size.
// 
// Time Complexity: O(N^2), where NN is the length of stones.
// Space Complexity: O(N^2)
class Solution {
    func removeStones(_ stones: [[Int]]) -> Int {
        guard !stones.isEmpty else { return 0 }
        
        let n = stones.count
        var map = Array(repeating: Array(repeating: 0, count: n), count: n)
        for i in 0..<n {
            var j = i+1
            while j < n {
                if stones[i][0] == stones[j][0] || stones[i][1] == stones[j][1] {
                    // same row or same column
                    map[i][0] += 1
                    map[i][map[i][0]] = j
                    
                    map[j][0] += 1
                    map[j][map[j][0]] = i
                }
                j += 1
            }
        }
        
        print(map)
        var stones = 0
        var visited = Array(repeating: false, count: n)
        for i in 0..<n {
            if !visited[i] {
                // bfs
                var stack = [Int]()
                stack.append(i)
                visited[i] = true
                stones -= 1
                
                while !stack.isEmpty {
                    let node = stack.removeLast()
                    stones += 1
                    var k = 1
                    while k <= map[node][0] {
                        let next = map[node][k]
                        if !visited[next] {
                            stack.append(next)
                            visited[next] = true
                        }
                        k += 1
                    }
                }
            }
        }
        return stones
    }
}

// Solution 2: Union find
// Let's connect row i to column j, which will be represented by j+10000. The answer is the number of components after making all the connections.
// Note that for brevity, our DSU implementation does not use union-by-rank. This makes the asymptotic time complexity larger.
// 
// Time Complexity: O(N \log N)O(NlogN), where NN is the length of stones. (If we used union-by-rank, this can be O(N * \alpha(N))O(N∗α(N)), where \alphaα is the Inverse-Ackermann function.)
// Space Complexity: O(N)O(N).
class Solution {
    func removeStones(_ stones: [[Int]]) -> Int {
        let n = stones.count
        var dsu = DSU(20000)
        
        for stone in stones {
            dsu.union(stone[0], stone[1] + 10000)
        }

        var set = Set<Int>()
        for stone in stones {
            set.insert(dsu.find(stone[0]))
        }
        
        return n-set.count
    }
}

class DSU {
    var parent: [Int]
    init(_ len: Int) {
        parent = Array(0..<len)
    }
    
    func find(_ x: Int) -> Int {
        if x != parent[x] {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }
    
    func union(_ x: Int, _ y: Int) {
        parent[find(x)] = find(y)
    }
}


// Solution 3: dfs/bfs
// for each stone, remove its same row/column one
// 
// Time complexity: O(nlogn)
// Space complexity: O(n)
class Solution {
    func removeStones(_ stones: [[Int]]) -> Int {
        guard !stones.isEmpty else { return 0 }
        
        let n = stones.count
        var xy = [Int: Set<Int>]()
        var yx = [Int: Set<Int>]()
        
        for (i, ivalue) in stones.enumerated() {
            xy[ivalue[0], default: Set<Int>()].insert(ivalue[1])
            yx[ivalue[1], default: Set<Int>()].insert(ivalue[0])
        }
        
        var num = 0
        for stone in stones {
            dfs(stone[0], stone[1], &num, &xy, &yx)
        }
        return num
    }
    
    func dfs(_ x: Int, _ y: Int, _ num: inout Int, _ xy: inout [Int: Set<Int>], _ yx: inout [Int: Set<Int>]) {
        xy[x]?.remove(y)
        yx[y]?.remove(x)
        
        while (xy[x]?.count ?? 0) > 0 {
            num += 1
            dfs(x, xy[x]!.first!, &num, &xy, &yx)
        }
        
        while (yx[y]?.count ?? 0) > 0 {
            num += 1
            dfs(yx[y]!.first!, y, &num, &xy, &yx)
        }
    }
}

