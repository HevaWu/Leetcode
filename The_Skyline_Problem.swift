/*
A city's skyline is the outer contour of the silhouette formed by all the buildings in that city when viewed from a distance. Given the locations and heights of all the buildings, return the skyline formed by these buildings collectively.

The geometric information of each building is given in the array buildings where buildings[i] = [lefti, righti, heighti]:

lefti is the x coordinate of the left edge of the ith building.
righti is the x coordinate of the right edge of the ith building.
heighti is the height of the ith building.
You may assume all buildings are perfect rectangles grounded on an absolutely flat surface at height 0.

The skyline should be represented as a list of "key points" sorted by their x-coordinate in the form [[x1,y1],[x2,y2],...]. Each key point is the left endpoint of some horizontal segment in the skyline except the last point in the list, which always has a y-coordinate 0 and is used to mark the skyline's termination where the rightmost building ends. Any ground between the leftmost and rightmost buildings should be part of the skyline's contour.

Note: There must be no consecutive horizontal lines of equal height in the output skyline. For instance, [...,[2 3],[4 5],[7 5],[11 5],[12 7],...] is not acceptable; the three lines of height 5 should be merged into one in the final output as such: [...,[2 3],[4 5],[12 7],...]

 

Example 1:


Input: buildings = [[2,9,10],[3,7,15],[5,12,12],[15,20,10],[19,24,8]]
Output: [[2,10],[3,15],[7,12],[12,0],[15,10],[20,8],[24,0]]
Explanation:
Figure A shows the buildings of the input.
Figure B shows the skyline formed by those buildings. The red points in figure B represent the key points in the output list.
Example 2:

Input: buildings = [[0,2,3],[2,5,3]]
Output: [[0,3],[5,0]]
 

Constraints:

1 <= buildings.length <= 104
0 <= lefti < righti <= 231 - 1
1 <= heighti <= 231 - 1
buildings is sorted by lefti in non-decreasing order.
*/

/*
Solution 2:
backTrack

improve sort?
*/
class Solution {
    func getSkyline(_ buildings: [[Int]]) -> [[Int]] {
        func backTrack(_ start: Int, _ end: Int) -> [[Int]] {
            guard start < end else { return [] }
            
            let count = end-start
            if count == 1 {
                return [[buildings[start][0], buildings[start][2]],
                       [buildings[start][1], 0]]
            }
            
            let mid = start+(end-start)/2
            
            let l = backTrack(start, mid)
            let r = backTrack(mid, end)
            
            var res = [[Int]]()
            
            // merge
            var li = 0
            var lh = 0
            
            var ri = 0
            var rh = 0
            
            var maxh = 0
            
            while li < l.count, ri < r.count {
                var cur = 0
                if l[li][0] < r[ri][0] {
                    lh = l[li][1]
                    cur = l[li][0]
                    li += 1
                } else {
                    rh = r[ri][1]
                    cur = r[ri][0]
                    ri += 1
                }
                
                var h = max(lh, rh)
                if h != maxh {
                    if res.count > 0, res[res.count-1][0] == cur {
                        res[res.count-1][1] = h
                    } else {
                        res.append([cur, h])
                    }
                    maxh = h
                }
            }
            
            while li < l.count {
                lh = l[li][1]
                var h = max(lh, rh)
                if h != maxh {
                    if res.count > 0, res[res.count-1][0] == l[li][0] {
                        res[res.count-1][1] = l[li][1]
                    } else {
                        res.append([l[li][0], h])
                    }
                    maxh = h
                }
                li += 1
            }
            
            while ri < r.count {
                rh = r[ri][1]
                var h = max(lh, rh)
                if h != maxh {
                    if res.count > 0, res[res.count-1][0] == r[ri][0] {
                        res[res.count-1][1] = r[ri][1]
                    } else {
                        res.append([r[ri][0], h])
                    }
                    maxh = h
                }
                ri += 1
            }
            
            return res
        }
        
        return backTrack(0, buildings.count)
    }
}

/*
Solution 1:

- put buildings to heights, (b[0], b[2]) means left side, (b[0], -b[2]) means right side
- sort height by left, then height
- for each h in height, check if curHeight value will changed or not, if changed, append it to result

TimeComplexity: O(nlogn)
Space Complexity: O(n)
*/
class Solution {
    func getSkyline(_ buildings: [[Int]]) -> [[Int]] {
        var heights = [(Int, Int)]()
        for b in buildings {
            heights.append((b[0], b[2]))
            heights.append((b[1], -b[2]))
        }
        
        // sort by left, then height
        heights.sort(by: { first, second in
            if first.0 == second.0 {
                // for same index,
                // if both of them are at left, sort by abs(first.1) > abs(second.1)
                // if both of them are at right, sort by abs(first.1) < abs(second.1)
                // if one of them means left, return this one first 
                if first.1 * second.1 > 0 {
                    return first.1 > second.1
                } else {
                    return first.1 > 0
                }
            } else {
                return first.0 < second.0
            }
        })
        // print(heights)
        
        var res = [[Int]]()
        
        var map = [Int: Int]()
        // use it to control right base line
        map[0] = 1
        
        var preMaxHeight = 0
        
        for h in heights {
            var curHeight = preMaxHeight
            if h.1 > 0 {
                map[h.1, default: 0] += 1
                curHeight = max(curHeight, h.1)
            } else {
                // use -h.1 to find this buildings left side
                guard let val = map[-h.1] else { break }
                
                if val == 1 {
                    // only one building
                    map[-h.1] = nil
                    
                    // find remaining highest building
                    if let mapMaxHeight = map.keys.max() {
                        curHeight = mapMaxHeight
                    }
                } else {
                    map[-h.1] = val-1
                }
            }
            
            if curHeight != preMaxHeight {
                res.append([h.0, curHeight])
                preMaxHeight = curHeight
            }
        }
        
        return res
    }
}