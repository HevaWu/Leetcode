// Given a grid where each entry is only 0 or 1, find the number of corner rectangles.

// A corner rectangle is 4 distinct 1s on the grid that form an axis-aligned rectangle. Note that only the corners need to have the value 1. Also, all four 1s used must be distinct.

 

// Example 1:

// Input: grid = 
// [[1, 0, 0, 1, 0],
//  [0, 0, 1, 0, 1],
//  [0, 0, 0, 1, 0],
//  [1, 0, 1, 0, 1]]
// Output: 1
// Explanation: There is only one corner rectangle, with corners grid[1][2], grid[1][4], grid[3][2], grid[3][4].
 

// Example 2:

// Input: grid = 
// [[1, 1, 1],
//  [1, 1, 1],
//  [1, 1, 1]]
// Output: 9
// Explanation: There are four 2x2 rectangles, four 2x3 and 3x2 rectangles, and one 3x3 rectangle.
 

// Example 3:

// Input: grid = 
// [[1, 1, 1, 1]]
// Output: 0
// Explanation: Rectangles must have four distinct corners.
 

// Note:

// The number of rows and columns of grid will each be in the range [1, 200].
// Each grid[i][j] will be either 0 or 1.
// The number of 1s in the grid will be at most 6000.

// 
// for each additional row, how many more rectangles are added?
// For each pair of 1s in the new row (say at new_row[i] and new_row[j]), we could create more rectangles where that pair forms the base. The number of new rectangles is the number of times some previous row had row[i] = row[j] = 1.
// 
// Let's maintain a count count[i, j], the number of times we saw row[i] = row[j] = 1. When we process a new row, for every pair new_row[i] = new_row[j] = 1, we add count[i, j] to the answer, then we increment count[i, j].
// 
// Time complexity: O(n* m^2)
// Spce complexity: O(m)
class Solution {
    func countCornerRectangles(_ grid: [[Int]]) -> Int {
        guard grid.count >= 2, grid[0].count >= 2 else { return 0 }
        
        var map = [Int: Int]()
        var count = 0
        for row in grid {
            for c1 in 0..<row.count where row[c1] == 1 {
                for c2 in c1+1..<row.count where row[c2] == 1 {
                    var temp = c1*200 + c2
                    var pre = map[temp, default: 0]
                    count += pre
                    map[temp] = pre + 1
                }
            }
        }
        return count
    }
}

// Solution 2: 
// When a row is filled with XX 1s, we do O(X^2)work to enumerate every pair of 1s. This is okay when XX is small, but expensive when XX is big.
// Say the entire top row is filled with 1s. When looking at the next row with say, f 1s that match the top row, the number of rectangles created is just the number of pairs of 1s, which is f * (f-1) / 2. We could find each f quickly using a Set and a simple linear scan of each row.
// Let's call a row to be heavy if it has more than \sqrt N 
// points. The above algorithm changes the complexity of counting a heavy row from O(C^2)to O(N)O(N), and there are at most \sqrt Nheavy rows.
// 
// Time Complexity: O(N \sqrt N + R*C) where NN is the number of ones in the grid.
// Space Complexity: O(N + R + C^2)in additional space, for rows, target, and count.
class Solution {
    func countCornerRectangles(_ grid: [[Int]]) -> Int {
        guard grid.count >= 2, grid[0].count >= 2 else { return 0 }
        
        var rows = [[Int]]()
        var N = 0
        for r in 0..<grid.count {
            rows.append([Int]())
            for c in 0..<grid[0].count {
                if grid[r][c] == 1 {
                    rows[r].append(c)
                    N += 1
                }
            }
        }
        
        var sqrtN = Int(sqrt(Double(N)))
        var map = [Int: Int]()
        var count = 0
        
        for r in 0..<grid.count {
            if rows[r].count >= sqrtN {
                var target = Set(rows[r])
                
                for r1 in 0..<grid.count {
                    if r1 <= r && rows[r1].count >= sqrtN { continue }
                    var temp = 0
                    for c1 in rows[r1] {
                        if target.contains(c1) { temp += 1 }
                    }
                    count += temp * (temp-1)/2
                }
            } else {
                for i1 in 0..<rows[r].count {
                    var c1 = rows[r][i1]
                    for i2 in i1+1..<rows[r].count {
                        var c2 = rows[r][i2]
                        var temp = map[200*c1+c2, default: 0]
                        count += temp
                        map[200*c1+c2] = temp+1
                    }
                }
            }
        }
        
        return count
    }
}