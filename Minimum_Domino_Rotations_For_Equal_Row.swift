// In a row of dominoes, A[i] and B[i] represent the top and bottom halves of the i-th domino.  (A domino is a tile with two numbers from 1 to 6 - one on each half of the tile.)

// We may rotate the i-th domino, so that A[i] and B[i] swap values.

// Return the minimum number of rotations so that all the values in A are the same, or all the values in B are the same.

// If it cannot be done, return -1.

 

// Example 1:



// Input: A = [2,1,2,4,2,2], B = [5,2,6,2,3,2]
// Output: 2
// Explanation: 
// The first figure represents the dominoes as given by A and B: before we do any rotations.
// If we rotate the second and fourth dominoes, we can make every value in the top row equal to 2, as indicated by the second figure.
// Example 2:

// Input: A = [3,5,1,2,3], B = [3,6,3,3,4]
// Output: -1
// Explanation: 
// In this case, it is not possible to rotate the dominoes to make one row of values equal.
 

// Note:

// 1 <= A[i], B[i] <= 6
// 2 <= A.length == B.length <= 20000

// Solution1: Greedy
// 1 . One could make all elements of A row or B row to be the same and equal to A[i] value. For example, if one picks up the 0th element, it's possible to make all elements of A row to be equal to 2.
// 2 . One could make all elements of A row or B row to be the same and equal to B[i] value. For example, if one picks up the 1th element, it's possible to make all elements of B row to be equal to 2.
// 3 . It's impossible to make all elements of A row or B row to have the same A[i] or B[i] value.
// 
// Pick up the first element. It has two sides: A[0] and B[0].
// Check if one could make all elements in A row or B row to be equal to A[0]. If yes, return the minimum number of rotations needed.
// Check if one could make all elements in A row or B row to be equal to B[0]. If yes, return the minimum number of rotations needed.
// Otherwise return -1.
// 
// Time complexity : \mathcal{O}(N)O(N) since here one iterates over the arrays not more than two times.
// Space complexity : \mathcal{O}(1)O(1) since it's a constant space solution.
class Solution {
    func minDominoRotations(_ A: [Int], _ B: [Int]) -> Int {
        let n = A.count
        let checkA = check(A[0], A, B, n)
        
        if checkA != -1 || A[0] == B[0] {
            return checkA
        } else {
            return check(B[0], A, B, n)
        }
    }
    
    func check(_ value: Int, _ A: [Int], _ B: [Int], _ count: Int) -> Int {
        var rotateA = 0
        var rotateB = 0
        for i in 0..<count {
            if A[i] != value && B[i] != value {
                return -1
            } else if A[i] != value {
                rotateA += 1
            } else if B[i] != value {
                rotateB += 1
            }
        }
        return min(rotateA, rotateB)
    }
}

// Solution2: 
// count each dominoe number value, then minus the common one 
// 
// Time complexity: O(n+7)
// Space complexity: O(21) constant time
class Solution {
    func minDominoRotations(_ A: [Int], _ B: [Int]) -> Int {
        var domA = Array(repeating: 0, count: 7)
        var domB = Array(repeating: 0, count: 7)
        var common = Array(repeating: 0, count: 7)
        
        // count dominoes number 
        for i in 0..<A.count {
            domA[A[i]] += 1
            domB[B[i]] += 1
            if A[i] == B[i] {
                common[A[i]] += 1
            }
        }
        
        for i in 0..<7 {
            if domA[i]+domB[i]-common[i] == A.count {
                return min(domA[i], domB[i]) - common[i]
            }
        }
        return -1
    }
}



