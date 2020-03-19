// We are given a list of (axis-aligned) rectangles.  Each rectangle[i] = [x1, y1, x2, y2] , where (x1, y1) are the coordinates of the bottom-left corner, and (x2, y2) are the coordinates of the top-right corner of the ith rectangle.

// Find the total area covered by all rectangles in the plane.  Since the answer may be too large, return it modulo 10^9 + 7.



// Example 1:

// Input: [[0,0,2,2],[1,0,2,3],[1,0,3,1]]
// Output: 6
// Explanation: As illustrated in the picture.
// Example 2:

// Input: [[0,0,1000000000,1000000000]]
// Output: 49
// Explanation: The answer is 10^18 modulo (10^9 + 7), which is (10^9)^2 = (-7)^2 = 49.
// Note:

// 1 <= rectangles.length <= 200
// rectanges[i].length = 4
// 0 <= rectangles[i][j] <= 10^9
// The total area covered by all rectangles will never exceed 2^63 - 1 and thus will fit in a 64-bit signed integer.

// Solution 1: inclusion & exclusion
// If we do not know the above fact, we can prove it by considering any point in \bigg|\bigcup_{i=1}^n A_i Say this point occurs in all A_i (i \in S), and let |S| = n∣S∣=n. Then on the right side, it is counted \binom{n}{1} - \binom{n}{2} + \binom{n}{3} - \cdots \pm \binom{n}times. By considering the binomial expansion of (1 - 1)^n, this is in fact equal to 11.
// From Rectangle Area I, we know that the intersection of two axis-aligned rectangles is another axis-aligned rectangle (or nothing). So in particular, the intersection \bigcap_{i \in S} A_i is always a rectangle (or nothing).
// Now our algorithm proceeds as follows: for every subset SS of \{1, 2, 3, \cdots, N\}{1,2,3,⋯,N} (where NN is the number of rectangles), we'll calculate the intersection of the rectangles in that subset \bigcap_{i \in S} A_i, and then the area of that rectangle. This allows us to calculate algorithmically the right-hand side of the general equation we wrote earlier.
// 
// Time Complexity: O(N * 2^N), where NN is the number of rectangles.
// Space Complexity: O(N)O(N).

// Solution 2: Coordinate compression
// Re-map each x coordinate to 0, 1, 2, .... Independently, re-map all y coordinates too.
// We then have a problem that can be solved by brute force: for each rectangle with re-mapped coordinates (rx1, ry1, rx2, ry2), we can fill the grid grid[x][y] = True for rx1 <= x < rx2 and ry1 <= y < ry2.
// Afterwards, each grid[rx][ry] represents the area (imapx(rx+1) - imapx(rx)) * (imapy(ry+1) - imapy(ry)), where if x got remapped to rx, then imapx(rx) = x ("inverse-map-x of remapped-x equals x"), and similarly for imapy.
// 
// Time Complexity: O(N^3), where NN is the number of rectangles.
// Space Complexity: O(N^2)
class Solution {
    func rectangleArea(_ rectangles: [[Int]]) -> Int {
        let n = rectangles.count
        var Xvals = Set<Int>()
        var Yvals = Set<Int>()
        
        for rec in rectangles {
            Xvals.insert(rec[0])
            Xvals.insert(rec[2])
            Yvals.insert(rec[1])
            Yvals.insert(rec[3])
        }
        
        var imapx = Xvals.sorted()
        var imapy = Yvals.sorted()
        
        var mapx = [Int: Int]()
        var mapy = [Int: Int]()
        
        for i in 0..<imapx.count {
            mapx[imapx[i]] = i
        }
        for i in 0..<imapy.count {
            mapy[imapy[i]] = i
        }
        
        var grid = Array(repeating: Array(repeating: false, count: imapy.count), count: imapx.count)
        for rec in rectangles {
            for x in mapx[rec[0]]!..<mapx[rec[2]]! {
                for y in mapy[rec[1]]!..<mapy[rec[3]]! {
                    grid[x][y] = true
                }
            }
        }
        
        let mod: Int = 1_000_000_007
        var area = 0
        for x in 0..<grid.count {
            for y in 0..<grid[0].count {
                if grid[x][y] {
                    area += ((imapx[x+1] - imapx[x]) * (imapy[y+1] - imapy[y])) % mod
                }
            }
        }
        
        return area % mod
    }
}