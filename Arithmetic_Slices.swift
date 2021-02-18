/*
A sequence of numbers is called arithmetic if it consists of at least three elements and if the difference between any two consecutive elements is the same.

For example, these are arithmetic sequences:

1, 3, 5, 7, 9
7, 7, 7, 7
3, -1, -5, -9
The following sequence is not arithmetic.

1, 1, 2, 5, 7
 
A zero-indexed array A consisting of N numbers is given. A slice of that array is any pair of integers (P, Q) such that 0 <= P < Q < N.

A slice (P, Q) of the array A is called arithmetic if the sequence:
A[P], A[P + 1], ..., A[Q - 1], A[Q] is arithmetic. In particular, this means that P + 1 < Q.

The function should return the number of arithmetic slices in the array A.

 
Example:

A = [1, 2, 3, 4]

return: 3, for 3 arithmetic slices in A: [1, 2, 3], [2, 3, 4] and [1, 2, 3, 4] itself.
*/

/*
Solution 3
optimize solution 2
*/
class Solution {
    func numberOfArithmeticSlices(_ A: [Int]) -> Int {
        guard A.count >= 3 else { return 0 }
        
        var res = 0
        var dp = 0
        
        for i in 2..<A.count {
            if A[i]-A[i-1] == A[i-1]-A[i-2] {
                dp += 1
                res += dp
            } else {
                dp = 0
            }
        }
        return res
    }
}

/*
Solution 2
DP

Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func numberOfArithmeticSlices(_ A: [Int]) -> Int {
        guard A.count >= 3 else { return 0 }
        var res = 0
        
        let n = A.count
        var dp = Array(repeating: 0, count: n)
        
        for i in 2..<n {
            if A[i]-A[i-1] == A[i-1]-A[i-2] {
                dp[i] = 1+dp[ia-1]
                res += dp[i]
            }
        }
        return res
    }
}

/*
Solution 1
recursive

if a range of elements between the indices (i,j)(i,j) constitute an Arithmetic Slice, and another element A[j+1]A[j+1] is included such that A[j+1]A[j+1] and A[j]A[j] have the same difference as that of the previous common difference, the ranges between (i,j+1)(i,j+1) will constitutes an arithmetic slice. Further, if the original range (i,j)(i,j) doesn't form an arithmetic slice, adding new elements to this range won't do us any good. Thus, no more arithmetic slices can be obtained by adding new elements to it.



Time Complexity: O(n)
Space Complexity: O(n)
*/
class Solution {
    func numberOfArithmeticSlices(_ A: [Int]) -> Int {
        var res = 0
        _countSlice(A, A.count-1, &res)
        return res
    }
    
    func _countSlice(_ A: [Int], _ i: Int, _ res: inout Int) -> Int {
        if i < 2 { return 0 }
        var cur = 0
        if A[i]-A[i-1] == A[i-1]-A[i-2] {
            cur = 1 + _countSlice(A, i-1, &res)
            res += cur
        } else {
            _countSlice(A, i-1, &res)
        }
        return cur
    }
}