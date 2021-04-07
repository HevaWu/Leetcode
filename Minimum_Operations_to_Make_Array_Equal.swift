/*
You have an array arr of length n where arr[i] = (2 * i) + 1 for all valid values of i (i.e. 0 <= i < n).

In one operation, you can select two indices x and y where 0 <= x, y < n and subtract 1 from arr[x] and add 1 to arr[y] (i.e. perform arr[x] -=1 and arr[y] += 1). The goal is to make all the elements of the array equal. It is guaranteed that all the elements of the array can be made equal using some operations.

Given an integer n, the length of the array. Return the minimum number of operations needed to make all the elements of arr equal.



Example 1:

Input: n = 3
Output: 2
Explanation: arr = [1, 3, 5]
First operation choose x = 2 and y = 0, this leads arr to be [2, 3, 4]
In the second operation choose x = 2 and y = 0 again, thus arr = [3, 3, 3].
Example 2:

Input: n = 6
Output: 9


Constraints:

1 <= n <= 10^4
*/

/*
Soluton 1:
math

1,3,5,...,k
等差数列
Sn = n*(a1+an)/2

- odd
=> (n+1)/2 element
=> (n+1)/2 * (0 + n-1) / 2
ex: n = 5
1,3,5,7,9
for equal number, it should be 1+9 /2 = 5 <- same as n
operation: 4+2+0

- even
=> n/2 element need to badd
=> (n/2) * (1 + n-1) / 2
ex: n = 6
1,3,5,7,9,11
for equal number, it should be 1+11/2 = 6 <- same as n
operation: 5+3+1

Time Complexity: O(1)
Space Complexity: O(1)
*/
class Solution {
    func minOperations(_ n: Int) -> Int {
        if n % 2 == 0 {
            return (n*n)/4
        } else {
            return (n*n - 1) / 4
        }
    }
}