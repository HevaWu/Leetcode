/*
Koko loves to eat bananas. There are n piles of bananas, the ith pile has piles[i] bananas. The guards have gone and will come back in h hours.

Koko can decide her bananas-per-hour eating speed of k. Each hour, she chooses some pile of bananas and eats k bananas from that pile. If the pile has less than k bananas, she eats all of them instead and will not eat any more bananas during this hour.

Koko likes to eat slowly but still wants to finish eating all the bananas before the guards return.

Return the minimum integer k such that she can eat all the bananas within h hours.



Example 1:

Input: piles = [3,6,7,11], h = 8
Output: 4
Example 2:

Input: piles = [30,11,23,4,20], h = 5
Output: 30
Example 3:

Input: piles = [30,11,23,4,20], h = 6
Output: 23


Constraints:

1 <= piles.length <= 104
piles.length <= h <= 109
1 <= piles[i] <= 109
*/

/*
Solution 1:
binary search

min speed is 1
max speed is max(piles) which means fast way will eat all by piles.count hour

binary search to find the minimum speed

Time Complexity: O(nlogn)
Space Complexity: O(1)
*/
class Solution {
    public int minEatingSpeed(int[] piles, int h) {
        int minSpeed = 1;
        int maxSpeed = 1;
        for(int p : piles) {
            maxSpeed = Math.max(maxSpeed, p);
        }

        while (minSpeed < maxSpeed) {
            int midSpeed = minSpeed + (maxSpeed - minSpeed) / 2;
            if (!canEatAll(midSpeed, piles, h)) {
                minSpeed = midSpeed + 1;
            } else {
                maxSpeed = midSpeed;
            }
        }
        return minSpeed;
    }

    public boolean canEatAll(int speed, int[] piles, int h) {
        int willTake = 0;
        for(int p : piles) {
            willTake += Math.ceil((double) p / speed);
        }
        return willTake <= h;
    }
}