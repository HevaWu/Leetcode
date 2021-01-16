/*
We are playing the Guess Game. The game is as follows:

I pick a number from 1 to n. You have to guess which number I picked.

Every time you guess wrong, I will tell you whether the number I picked is higher or lower than your guess.

You call a pre-defined API int guess(int num), which returns 3 possible results:

-1: The number I picked is lower than your guess (i.e. pick < num).
1: The number I picked is higher than your guess (i.e. pick > num).
0: The number I picked is equal to your guess (i.e. pick == num).
Return the number that I picked.

 

Example 1:

Input: n = 10, pick = 6
Output: 6
Example 2:

Input: n = 1, pick = 1
Output: 1
Example 3:

Input: n = 2, pick = 1
Output: 1
Example 4:

Input: n = 2, pick = 2
Output: 2
 

Constraints:

1 <= n <= 231 - 1
1 <= pick <= n
*/

/*
Solution 2
Tenary Search

In Binary Search, we choose the middle element as the pivot in splitting. In Ternary Search, we choose two pivots (say m1m1 and m2m2) such that the given range is divided into three equal parts. If the required number numnum is less than m1m1 then we apply ternary search on the left segment of m1m1. If numnum lies between m1m1 and m2m2, we apply ternary search between m1m1 and m2m2. Otherwise we will search in the segment right to m2m2.

the total comparisons in the worst case for ternary and binary search are 1 + 4 \log_3 n and 1 + 2 \log_2 n, comparisons respectively. To determine which is larger, we can just look at the expression 2 \log_3 n, and \log_2 n. The expression 2 \log_3 ncan be written as \frac{2}{\log_2 3} \times \log_2 Since the value of \frac{2}{\log_2 3} s greater than one, Ternary Search does more comparisons than Binary Search in the worst case.

Time Complexity: O(log_3 n)
Space Complexity: O(1)
*/
/** 
 * Forward declaration of guess API.
 * @param  num -> your guess number
 * @return 	     -1 if the picked number is lower than your guess number
 *			      1 if the picked number is higher than your guess number
 *               otherwise return 0
 * func guess(_ num: Int) -> Int 
 */

class Solution : GuessGame {
    func guessNumber(_ n: Int) -> Int {
        var left = 0
        var right = n
        while left <= right {
            let mid1 = left + (right-left)/3
            let mid2 = right - (right-left)/3
            
            let temp1 = guess(mid1)
            let temp2 = guess(mid2)
            
            if temp1 == 0 {
                return mid1
            } else if temp2 == 0 {
                return mid2
            } else if temp1 < 0 {
                right = mid1 - 1
            } else if temp2 > 0 {
                left = mid2 + 1
            } else {
                left = mid1 + 1
                right = mid2 - 1
            }
        }
        return -1
    }
}

/*
Solution 1:
Binary Search

Time Complexity: O(logn)
Space Complexity: O(1)
*/
/** 
 * Forward declaration of guess API.
 * @param  num -> your guess number
 * @return 	     -1 if the picked number is lower than your guess number
 *			      1 if the picked number is higher than your guess number
 *               otherwise return 0
 * func guess(_ num: Int) -> Int 
 */

class Solution : GuessGame {
    func guessNumber(_ n: Int) -> Int {
        var left = 0
        var right = n
        while left <= right {
            let mid = left + (right-left)/2
            let temp = guess(mid)
            if temp == 0 {
                return mid
            } else if temp < 0 {
                // pick < guessed temp, check left side
                right = mid-1
            } else {
                left = mid+1
            }
        }
        return -1
    }
}