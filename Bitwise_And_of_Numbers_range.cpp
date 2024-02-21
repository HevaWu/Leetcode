/*
Given a range [m, n] where 0 <= m <= n <= 2147483647, return the bitwise AND of
all numbers in this range, inclusive.

For example, given the range [5, 7], you should return 4.
*/

/*
Solution 1:
right move one bit each time, until they equal to each other 
record the number of this bit, and return the value left move this number

Time Complexity: O(1)
Space Complexity: O(1)
*/
class Solution {
 public:
  int rangeBitwiseAnd(int m, int n) {
    /*if(m == n)
        return m;
    return m & rangeBitwiseAnd(m+1,n);*/
    /*int res = m;
    for(int i = m+1; i <= n; i++){
        res = res & i ;
    }
    return res;
    */

    if (m == n) return m;
    int i = 0;
    while (m != n && i < 32) {
      m >>= 1;
      n >>= 1;
      i++;
    }
    return m << i;
  }
};
