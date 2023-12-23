/*
Given a string path, where path[i] = 'N', 'S', 'E' or 'W', each representing moving one unit north, south, east, or west, respectively. You start at the origin (0, 0) on a 2D plane and walk on the path specified by path.

Return true if the path crosses itself at any point, that is, if at any time you are on a location you have previously visited. Return false otherwise.



Example 1:


Input: path = "NES"
Output: false
Explanation: Notice that the path doesn't cross any point more than once.
Example 2:


Input: path = "NESWW"
Output: true
Explanation: Notice that the path visits the origin twice.


Constraints:

1 <= path.length <= 104
path[i] is either 'N', 'S', 'E', or 'W'.
*/


/*
Solution 1:
use Set<Int> to store visited point (store r + 10000 * c)

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func isPathCrossing(_ path: String) -> Bool {
        // store r + 10000 * c
        var visited = Set<Int>()
        visited.insert(0)
        var r = 0
        var c = 0

        for p in path {
            switch p {
            case Character("N"): r -= 1
            case Character("S"): r += 1
            case Character("E"): c += 1
            case Character("W"): c -= 1
            default: continue
            }
            let val = r + 10000*c
            if visited.contains(val) {
                return true
            }
            visited.insert(val)
        }
        return false
    }
}
