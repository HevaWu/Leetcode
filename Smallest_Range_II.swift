/*
Given an array A of integers, for each integer A[i] we need to choose either x = -K or x = K, and add x to A[i] (only once).

After this process, we have some array B.

Return the smallest possible difference between the maximum value of B and the minimum value of B.

 

Example 1:

Input: A = [1], K = 0
Output: 0
Explanation: B = [1]
Example 2:

Input: A = [0,10], K = 2
Output: 6
Explanation: B = [2,8]
Example 3:

Input: A = [1,3,6], K = 3
Output: 3
Explanation: B = [4,6,3]
 

Note:

1 <= A.length <= 10000
0 <= A[i] <= 10000
0 <= K <= 10000
*/

/*
Solution 1:

idea:
for each A[i], if we add same K, the result will not change
transfer problem to add x==0 or x==2K

- sort A first, current min is A[0], max is A[n-1]
- check if we can reduce the difference
  - min = min(A[i+1], A[0]+2K)
  - max = max(max, A[i]+2K)

Time Complexity: O(nlogn)
*/
class Solution {
    func smallestRangeII(_ A: [Int], _ K: Int) -> Int {
        var A = A.sorted()
        
        let n = A.count
        var _max = A[n-1]
        var _min = A[0]
        var res = _max - _min
        let _K = 2*K
        
        for i in 0..<(n-1) {
            _max = max(_max, A[i] + _K)
            _min = min(A[i+1], A[0] + _K)
            res = min(res, _max - _min)
        }
        return res
    }
}