// Two images A and B are given, represented as binary, square matrices of the same size.  (A binary matrix has only 0s and 1s as values.)

// We translate one image however we choose (sliding it left, right, up, or down any number of units), and place it on top of the other image.  After, the overlap of this translation is the number of positions that have a 1 in both images.

// (Note also that a translation does not include any kind of rotation.)

// What is the largest possible overlap?

// Example 1:

// Input: A = [[1,1,0],
//             [0,1,0],
//             [0,1,0]]
//        B = [[0,0,0],
//             [0,1,1],
//             [0,0,1]]
// Output: 3
// Explanation: We slide A to right by 1 unit and down by 1 unit.
// Notes: 

// 1 <= A.length = A[0].length = B.length = B[0].length <= 30
// 0 <= A[i][j], B[i][j] <= 1

// Solution 1: translate by delta
// For each translation delta, we calculate the candidate answer overlap(delta), which is the size of the overlap if we shifted the matrix A by delta.
// We only need to check delta for which some point in A maps to some point in B, since a candidate overlap must be at least 1. Using a Set seen, we remember if we've calculated overlap(delta), so that we don't perform this expensive check more than once per delta.
// We use java.awt.Point (or complex in Python) to handle our 2D vectors gracefully. We could have also mapped a vector delta = (x, y) (which has coordinates between -(N-1) and N-1) to 2*N x + y for convenience. Note that we cannot map it to N*dx, dy as there would be interference: (0, N-1) and (1, -1) would map to the same point.
// 
// Time Complexity: O(N^6), where NN is the length of A or B.)
// Space complexity: O(n^2)
class Solution {
    func largestOverlap(_ A: [[Int]], _ B: [[Int]]) -> Int {
        let n = A.count
        
        // contains point (Int, Int) <- i,j
        // (Int, Int) is not hashable so we set [Int] at here
        var listA = [[Int]]()
        var listB = [[Int]]()
        for i in 0..<n {
            for j in 0..<n {
                if A[i][j] == 1 {
                    listA.append([i,j])
                }
                if B[i][j] == 1 {
                    listB.append([i,j])
                }
            }
        }
        
        var setB = Set(listB)
        
        var overlap = 0
        var visited = Set<[Int]>()
        for pa in listA {
            for pb in listB {
                // count from pb - pa
                let trans = [pb[0]-pa[0], pb[1]-pa[1]]
                if !visited.contains(trans) {
                    visited.insert(trans)
                    var temp = 0
                    for i in listA {
                        // check each pa + trans
                        if listB.contains([i[0]+trans[0], i[1]+trans[1]]) {
                            temp += 1
                        }
                    }
                    overlap = max(overlap, temp)
                }
            }
        }
        return overlap
    }
}

// Solution 2:
// count every possible delta = b - a we see. If we see say, 5 of the same delta = b - a, then the translation by delta must have overlap 5.
// 
// go through A & B, check each possible overlap,
// find the max count
// 
// Time Complexity: O(N^4), where NN is the length of A or B.
// Space Complexity: O(N^2).
class Solution {
    func largestOverlap(_ A: [[Int]], _ B: [[Int]]) -> Int {
        let n = A.count
        var count = Array(repeating: Array(repeating: 0, count: 2*n + 1), count: 2*n + 1)
        for i in 0..<n {
            for j in 0..<n where A[i][j] == 1 {
                for i1 in 0..<n {
                    for j1 in 0..<n where B[i1][j1] == 1 {
                        count[i-i1+n][j-j1+n] += 1
                    }
                }
            }
        }
        
        var overlap = 0
        for arr in count {
            overlap = max(overlap, arr.max() ?? 0)
        }
        return overlap
    }
}