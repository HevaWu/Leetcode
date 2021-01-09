/*
On the first row, we write a 0. Now in every subsequent row, we look at the previous row and replace each occurrence of 0 with 01, and each occurrence of 1 with 10.

Given row N and index K, return the K-th indexed symbol in row N. (The values of K are 1-indexed.) (1 indexed).

Examples:
Input: N = 1, K = 1
Output: 0

Input: N = 2, K = 1
Output: 0

Input: N = 2, K = 2
Output: 1

Input: N = 4, K = 5
Output: 1

Explanation:
row 1: 0
row 2: 01
row 3: 0110
row 4: 01101001
Note:

N will be an integer in the range [1, 30].
K will be an integer in the range [1, 2^(N-1)].

Hint 1: Try to represent the current (N, K) in terms of some (N-1, prevK). What is prevK ?

*/

/*
Solution 1:
f(n, k) can be decided by pre=f(n-1, (k+1)/2)
if k is even, 
  - pre == 0 ? 0 : 1
  - pre == 1 ? 1 : 0
if k is odd
  - pre == 0 ? 1 : 0
  - pre == 1 ? 0 : 1

Time Complexity: O(n)
Space Complexity: O(1)
*/
class Solution {
    func kthGrammar(_ N: Int, _ K: Int) -> Int {
        if N == 0 { return 0 }
        let pre = kthGrammar(N-1, (K+1)/2)
        return K%2 == 0 ? pre^1 : pre
    }
}