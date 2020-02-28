// We have a list of points on the plane.  Find the K closest points to the origin (0, 0).

// (Here, the distance between two points on a plane is the Euclidean distance.)

// You may return the answer in any order.  The answer is guaranteed to be unique (except for the order that it is in.)

 

// Example 1:

// Input: points = [[1,3],[-2,2]], K = 1
// Output: [[-2,2]]
// Explanation: 
// The distance between (1, 3) and the origin is sqrt(10).
// The distance between (-2, 2) and the origin is sqrt(8).
// Since sqrt(8) < sqrt(10), (-2, 2) is closer to the origin.
// We only want the closest K = 1 points from the origin, so the answer is just [[-2,2]].
// Example 2:

// Input: points = [[3,3],[5,-1],[-2,4]], K = 2
// Output: [[3,3],[-2,4]]
// (The answer [[-2,4],[3,3]] would also be accepted.)
 

// Note:

// 1 <= K <= points.length <= 10000
// -10000 < points[i][0] < 10000
// -10000 < points[i][1] < 10000

// Solution 1: Map
// use dic to help memorizing the dis of all the points, for same dis, use a linked list structure to solve it
// 
// TimeComplexity: O(nlogn)
// SpaceComplexity: O(n)
class Solution {
    func kClosest(_ points: [[Int]], _ K: Int) -> [[Int]] {
        guard points.count > K else { return points }
        
        // create a dic to help finding point
        // key is dis, value is the same dis points
        var dic = [Int: [[Int]]]()
        for point in points {
            let dis = point[0] * point[0] + point[1] * point[1]
            if let _ = dic[dis] {
                dic[dis]!.append(point)
            } else {
                dic[dis] = [point]
            }
        }
        
        var closet = [[Int]]()
        var dicKey = dic.keys.sorted()
        var dicIndex = 0
        var k = K
        while k > 0, dicIndex < dicKey.count {
            if let arr = dic[dicKey[dicIndex]] {
                for a in arr {
                    guard k > 0 else { break }
                    closet.append(a)
                    k -= 1 
                }
                dicIndex += 1
            }
        }
                   
        return closet
    }
}

// Solution 2
// Quick Sort
// 
// Time Complexity: O(N)O(N) in average case complexity, where NN is the length of points.
// Space Complexity: O(N)O(N).
class Solution {
    // memo the sorted array
    var sorted = [[Int]]()
    
    func kClosest(_ points: [[Int]], _ K: Int) -> [[Int]] {
        sorted = points
        check(0, points.count - 1, K)
        return Array(sorted[0...K-1])
    }
    
    func check(_ start: Int, _ end: Int, _ target: Int) {
        guard start < end else { return }
        let pivotIndex = Int.random(in: start...end)
        
        let index = sort(start, end, pivotIndex)
        
        if index == target {
            return 
        } else if index < target {
            check(index + 1, end, target)
        } else {
            check(start, index - 1, target)
        }
    }
    
    func sort(_ start: Int, _ end: Int, _ pivotIndex: Int) -> Int {
        let pivotDis = dist(sorted[pivotIndex])
        swap(end, pivotIndex)
        
        var tempIndex = start // for memo pivot
        for index in start...end {

            if dist(sorted[index]) < pivotDis {
                swap(index, tempIndex)
                tempIndex += 1
            }
        }
        
        swap(end, tempIndex)
        return tempIndex
    }
    
    func dist(_ point: [Int]) -> Int {
        return point[0] * point[0] + point[1] * point[1]
    }
    
    func swap(_ first: Int, _ second: Int) {
        let temp = sorted[first]
        sorted[first] = sorted[second]
        sorted[second] = temp
    }
}