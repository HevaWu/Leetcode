class Solution {
    func getAncestors(_ n: Int, _ edges: [[Int]]) -> [[Int]] {
        var res = Array(repeating: [Int](), count: n)
        var graph = Array(repeating: [Int](), count: n)
        for e in edges {
            graph[e[0]].append(e[1])
        }
        for i in 0..<n {
            var visited = Array(repeating: false, count: n)
            dfs(graph, i, i, &res, &visited)
        }
        for i in 0..<n {
            res[i].sort()
        }
        return res
    }

    func dfs(_ graph: [[Int]], _ parent: Int, _ cur: Int, _ res: inout [[Int]], _ visited: inout [Bool]) {
        visited[cur] = true
        for dest in graph[cur] {
            if !visited[dest] {
                res[dest].append(parent)
                dfs(graph, parent, dest, &res, &visited)
            }
        }
    }
}
