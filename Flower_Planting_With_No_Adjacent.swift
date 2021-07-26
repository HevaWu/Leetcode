/*
You have n gardens, labeled from 1 to n, and an array paths where paths[i] = [xi, yi] describes a bidirectional path between garden xi to garden yi. In each garden, you want to plant one of 4 types of flowers.

All gardens have at most 3 paths coming into or leaving it.

Your task is to choose a flower type for each garden such that, for any two gardens connected by a path, they have different types of flowers.

Return any such a choice as an array answer, where answer[i] is the type of flower planted in the (i+1)th garden. The flower types are denoted 1, 2, 3, or 4. It is guaranteed an answer exists.



Example 1:

Input: n = 3, paths = [[1,2],[2,3],[3,1]]
Output: [1,2,3]
Explanation:
Gardens 1 and 2 have different types.
Gardens 2 and 3 have different types.
Gardens 3 and 1 have different types.
Hence, [1,2,3] is a valid answer. Other valid answers include [1,2,4], [1,4,2], and [3,2,1].
Example 2:

Input: n = 4, paths = [[1,2],[3,4]]
Output: [1,2,1,2]
Example 3:

Input: n = 4, paths = [[1,2],[2,3],[3,4],[4,1],[1,3],[2,4]]
Output: [1,2,3,4]


Constraints:

1 <= n <= 104
0 <= paths.length <= 2 * 104
paths[i].length == 2
1 <= xi, yi <= n
xi != yi
Every garden has at most 3 paths coming into or leaving it.
*/

/*
Solution 2:
iterate 4 colors, to see if we can put this color into arr

Time Complexity: O(4*n*6)
Space Complexity: O(E + n)
*/
class Solution {
    func gardenNoAdj(_ n: Int, _ paths: [[Int]]) -> [Int] {
        if paths.isEmpty {
            return Array(repeating: 1, count: n)
        }

        var graph = [Int: [Int]]()
        for p in paths {
            graph[p[0]-1, default: [Int]()].append(p[1]-1)
            graph[p[1]-1, default: [Int]()].append(p[0]-1)
        }

        var arr = Array(repeating: -1, count: n)
        for i in 0..<n {
            for c in 1...4 {
                var canPut = true

                // try see if we can put c color in ith garden
                if let list = graph[i] {
                    for next in list {
                        if arr[next] == c {
                            canPut = false
                            break
                        }
                    }
                }

                if canPut {
                    arr[i] = c
                    break
                }
            }
        }
        return arr
    }
}

/*
Solution 1:
memorization backtracking

Time Complexity: O(4n*6)
Space Complexity: O(E + 4n)
*/
class Solution {
    func gardenNoAdj(_ n: Int, _ paths: [[Int]]) -> [Int] {
        var graph = [Int: [Int]]()
        for p in paths {
            graph[p[0]-1, default: [Int]()].append(p[1]-1)
            graph[p[1]-1, default: [Int]()].append(p[0]-1)
        }

        var arr = Array(repeating: -1, count: n)
        var visited = Set<Int>()

        var cache: [[Bool?]] = Array(
            repeating: Array(repeating: nil, count: 5),
            count: n
        )

        for i in 0..<n {
            guard !visited.contains(i) else { continue }
            visited.insert(i)

            for color in 1...4 {
                if canPut(color, i, arr, graph) {
                    arr[i] = color
                    if check(i, color, n, graph, &arr, &visited, &cache) {
                        return arr
                    }
                }
            }
        }

        return arr
    }

    func check(_ index: Int, _ color: Int, _ n: Int,
               _ graph: [Int: [Int]], _ arr: inout [Int],
               _ visited: inout Set<Int>,
               _ cache: inout [[Bool?]]) -> Bool {
        // defer {
        //     print(index, color, cache[index][color])
        // }
        if let val = cache[index][color] {
            return val
        }

        if visited.count == n {
            cache[index][color] = true
            return true
        } else {
            if let list = graph[index] {
                for next in list {
                    guard !visited.contains(next) else { continue }
                    visited.insert(next)
                    for c in 1...4 {
                        if canPut(c, next, arr, graph) {
                            arr[next] = c
                            if check(next, c, n, graph, &arr, &visited, &cache) {
                                cache[index][c] = true
                                return true
                            }
                        }
                    }
                    visited.remove(next)
                }
            }
            cache[index][color] = false
            return false
        }
    }

    func canPut(_ color: Int, _ index: Int,
                _ arr: [Int], _ graph: [Int: [Int]]) -> Bool {
        // check index connecting garden
        if let list = graph[index] {
            for next in list {
                if arr[next] == color {
                    return false
                }
            }
        }
        return true
    }
}

/*
TLE
*/
class Solution {
    func gardenNoAdj(_ n: Int, _ paths: [[Int]]) -> [Int] {
        var graph = [Int: [Int]]()
        for p in paths {
            graph[p[0]-1, default: [Int]()].append(p[1]-1)
            graph[p[1]-1, default: [Int]()].append(p[0]-1)
        }

        var arr = Array(repeating: -1, count: n)
        var visited = Set<Int>()

        for i in 0..<n {
            if !visited.contains(i) {
                visited.insert(i)
                check(i, n, graph, &arr, &visited)
            }
        }

        return arr
    }

    func check(_ index: Int, _ n: Int,
               _ graph: [Int: [Int]], _ arr: inout [Int],
               _ visited: inout Set<Int>) -> Bool {

        for color in 1...4 {
            if canPut(color, index, arr, graph) {
                arr[index] = color

                if visited.count == n {
                    // all node is mapped
                    return true
                }

                if let list = graph[index] {
                    for next in list {
                        if !visited.contains(next) {
                            visited.insert(next)
                            if check(next, n, graph, &arr, &visited) {
                                return true
                            }
                            visited.remove(next)
                        }
                    }
                }
            }
        }
        return false
    }

    func canPut(_ color: Int, _ index: Int,
                _ arr: [Int], _ graph: [Int: [Int]]) -> Bool {
        // check index connecting garden
        if let list = graph[index] {
            for next in list {
                if arr[next] == color {
                    return false
                }
            }
        }
        return true
    }
}