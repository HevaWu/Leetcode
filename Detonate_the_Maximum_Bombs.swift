/*
You are given a list of bombs. The range of a bomb is defined as the area where its effect can be felt. This area is in the shape of a circle with the center as the location of the bomb.

The bombs are represented by a 0-indexed 2D integer array bombs where bombs[i] = [xi, yi, ri]. xi and yi denote the X-coordinate and Y-coordinate of the location of the ith bomb, whereas ri denotes the radius of its range.

You may choose to detonate a single bomb. When a bomb is detonated, it will detonate all bombs that lie in its range. These bombs will further detonate the bombs that lie in their ranges.

Given the list of bombs, return the maximum number of bombs that can be detonated if you are allowed to detonate only one bomb.



Example 1:


Input: bombs = [[2,1,3],[6,1,4]]
Output: 2
Explanation:
The above figure shows the positions and ranges of the 2 bombs.
If we detonate the left bomb, the right bomb will not be affected.
But if we detonate the right bomb, both bombs will be detonated.
So the maximum bombs that can be detonated is max(1, 2) = 2.
Example 2:


Input: bombs = [[1,1,5],[10,10,5]]
Output: 1
Explanation:
Detonating either bomb will not detonate the other bomb, so the maximum number of bombs that can be detonated is 1.
Example 3:


Input: bombs = [[1,2,3],[2,3,1],[3,4,2],[4,5,3],[5,6,4]]
Output: 5
Explanation:
The best bomb to detonate is bomb 0 because:
- Bomb 0 detonates bombs 1 and 2. The red circle denotes the range of bomb 0.
- Bomb 2 detonates bomb 3. The blue circle denotes the range of bomb 2.
- Bomb 3 detonates bomb 4. The green circle denotes the range of bomb 3.
Thus all 5 bombs are detonated.


Constraints:

1 <= bombs.length <= 100
bombs[i].length == 3
1 <= xi, yi, ri <= 105
*/

/*
Solution 1:
DFS

build direction graph to connect bombs which can detonated another
use DFS to find maximum bombs that can be detonated with starting from this bomb

Time Complexity: O(n^2)
Space Complexity: O(n^2)
*/
class Solution {
    func maximumDetonation(_ bombs: [[Int]]) -> Int {
        let n = bombs.count
        // graph[i] is the nodes that can be detonated by i
        var graph = Array(repeating: [Int](), count: n)
        for i in 1..<n {
            for j in 0..<i {
                if isCross(bombs[i], bombs[j]) {
                    graph[i].append(j)
                }
                if isCross(bombs[j], bombs[i]) {
                    graph[j].append(i)
                }
            }
        }

        var val = 1
        for i in 0..<n {
            var visited = Array(repeating: false, count: n)
            visited[i] = true
            val = max(val, check(i, graph,  &visited))
        }

        return val
    }

    func check(_ index: Int, _ graph: [[Int]], _ visited: inout [Bool]) -> Int {
        var val = 1
        for next in graph[index] {
            if !visited[next] {
                visited[next] = true
                val += check(next, graph, &visited)
            }
        }
        return val
    }

    func isCross(_ b1: [Int], _ b2: [Int]) -> Bool {
        let x = b1[0] - b2[0]
        let y = b1[1] - b2[1]
        let dist = sqrt(Double(x*x + y*y))
        return dist <= Double(b1[2])
    }
}
