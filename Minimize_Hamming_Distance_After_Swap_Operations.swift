/*
You are given two integer arrays, source and target, both of length n. You are also given an array allowedSwaps where each allowedSwaps[i] = [ai, bi] indicates that you are allowed to swap the elements at index ai and index bi (0-indexed) of array source. Note that you can swap elements at a specific pair of indices multiple times and in any order.

The Hamming distance of two arrays of the same length, source and target, is the number of positions where the elements are different. Formally, it is the number of indices i for 0 <= i <= n-1 where source[i] != target[i] (0-indexed).

Return the minimum Hamming distance of source and target after performing any amount of swap operations on array source.



Example 1:

Input: source = [1,2,3,4], target = [2,1,4,5], allowedSwaps = [[0,1],[2,3]]
Output: 1
Explanation: source can be transformed the following way:
- Swap indices 0 and 1: source = [2,1,3,4]
- Swap indices 2 and 3: source = [2,1,4,3]
The Hamming distance of source and target is 1 as they differ in 1 position: index 3.
Example 2:

Input: source = [1,2,3,4], target = [1,3,2,4], allowedSwaps = []
Output: 2
Explanation: There are no allowed swaps.
The Hamming distance of source and target is 2 as they differ in 2 positions: index 1 and index 2.
Example 3:

Input: source = [5,1,2,4,3], target = [1,5,4,2,3], allowedSwaps = [[0,4],[4,2],[1,3],[1,4]]
Output: 0


Constraints:

n == source.length == target.length
1 <= n <= 105
1 <= source[i], target[i] <= 105
0 <= allowedSwaps.length <= 105
allowedSwaps[i].length == 2
0 <= ai, bi <= n - 1
ai != bi
*/

/*
Solution 1:
UF + map
disjoint set union find

- use union find to help recording which components is in which group
- for each component group, after removing common element in source and target, the remain will contribute to the total hamming distance

Time Complexity: O(n * )
- O(n) for normal union find
*/
class Solution {
    func minimumHammingDistance(_ source: [Int], _ target: [Int], _ allowedSwaps: [[Int]]) -> Int {
        let n = source.count

        var uf = UF(n)
        for swap in allowedSwaps {
            uf.union(swap[0], swap[1])
        }

        // components with same parent will put in same group
        var group = Array(repeating: [Int](), count: n)
        for i in 0..<n {
            group[uf.find(i)].append(i)
        }

        var dis = 0
        for g in group {
            if g.isEmpty { continue }

            var remain = g.count

            // list component in same group
            var s_map = [Int: Int]()
            var t_map = [Int: Int]()
            for i in g {
                s_map[source[i], default: 0] += 1
                t_map[target[i], default: 0] += 1
            }

            // remove same component
            for k in s_map.keys {
                if let t_val = t_map[k] {
                    let s_val = s_map[k]!
                    let common = min(t_val, s_val)
                    t_map[k] = common == t_val ? nil : t_val-common
                    s_map[k] = common == s_val ? nil : s_val-common

                    remain -= common
                }
            }

            // add remain in final Hamming distance
            dis += remain
        }

        return dis
    }
}

class UF {
    var parent: [Int]
    init(_ n: Int) {
        parent = Array(0..<n)
    }

    func find(_ x: Int) -> Int {
        if parent[x] != x {
            parent[x] = find(parent[x])
        }
        return parent[x]
    }

    func union(_ x: Int, _ y: Int) {
        parent[find(x)] = find(y)
    }
}