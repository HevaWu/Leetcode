/*
You have a long flowerbed in which some of the plots are planted, and some are not. However, flowers cannot be planted in adjacent plots.

Given an integer array flowerbed containing 0's and 1's, where 0 means empty and 1 means not empty, and an integer n, return if n new flowers can be planted in the flowerbed without violating the no-adjacent-flowers rule.



Example 1:

Input: flowerbed = [1,0,0,0,1], n = 1
Output: true
Example 2:

Input: flowerbed = [1,0,0,0,1], n = 2
Output: false


Constraints:

1 <= flowerbed.length <= 2 * 104
flowerbed[i] is 0 or 1.
There are no two adjacent flowers in flowerbed.
0 <= n <= flowerbed.length
*/

/*
Solution 1:
iterate once

Time Complexity: O(size)
Space Complexity: O(1)
*/
class Solution {
    public boolean canPlaceFlowers(int[] flowerbed, int n) {
        if (n == 0) { return true; }
        int size = flowerbed.length;

        if (size == 1) {
            return (flowerbed[0] == 0 && n == 1);
        }

        for(int i = 0; i < size; i++) {
            if (flowerbed[i] == 0) {
                if ((i == 0 && flowerbed[i+1] == 0)
                   || (i == size-1 && flowerbed[i-1] == 0)
                    || (i-1 >= 0 && i+1 < size && flowerbed[i-1] == 0 && flowerbed[i+1] == 0)) {
                    n -= 1;
                    flowerbed[i] = 1;
                    if (n == 0) { return true; }
                }
            }
        }


        return false;
    }
}