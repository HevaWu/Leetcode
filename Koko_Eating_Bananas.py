'''
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
'''

'''
Solution 1:
binary search

min speed is 1
max speed is max(piles) which means fast way will eat all by piles.count hour

binary search to find the minimum speed

Time Complexity: O(nlogn)
Space Complexity: O(1)
'''
class Solution:
    def minEatingSpeed(self, piles: List[int], h: int) -> int:
        minSpeed = 1
        maxSpeed = max(piles)

        while minSpeed < maxSpeed:
            midSpeed = minSpeed + (maxSpeed - minSpeed) // 2
            if self.canEatAll(midSpeed, piles, h) == False:
                minSpeed = midSpeed + 1
            else:
                maxSpeed = midSpeed

        return minSpeed

    def canEatAll(self, speed: int, piles: List[int], h: int) -> bool:
        willTake = 0
        for p in piles:
            willTake += math.ceil(p / speed)
        return willTake <= h

