'''
Given an array of integers nums, sort the array in ascending order.



Example 1:

Input: nums = [5,2,3,1]
Output: [1,2,3,5]
Example 2:

Input: nums = [5,1,1,2,0,0]
Output: [0,0,1,1,2,5]


Constraints:

1 <= nums.length <= 50000
-50000 <= nums[i] <= 50000
'''

'''
Solution 4:
binary insert

Time Complexity: O(nlogn)
Space Complexity: O(n)
'''
class Solution:
    def sortArray(self, nums: List[int]) -> List[int]:
        res = []

        def insert(num: int):
            nonlocal res
            if not res:
                res.append(num)
                return
            l = 0
            r = len(res)-1
            while l < r:
                mid = l + (r-l)//2
                if res[mid] < num:
                    l = mid+1
                else:
                    r = mid
            index = l+1 if res[l] < num else l
            res.insert(index, num)

        for num in nums:
            insert(num)

        return res
