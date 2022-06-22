'''
Find the kth largest element in an unsorted array. Note that it is the kth largest element in the sorted order, not the kth distinct element.

Example 1:

Input: [3,2,1,5,6,4] and k = 2
Output: 5
Example 2:

Input: [3,2,3,1,2,4,5,5,6] and k = 4
Output: 4
Note:
You may assume k is always valid, 1 ≤ k ≤ array's length.
'''

'''
Solution: default function
TimeComplexity: O(klogn)
SpaceComplexity: O(n)
'''
class Solution:
    def findKthLargest(self, nums: List[int], k: int) -> int:
        nums.sort()
        return nums[len(nums)-k]

'''
Solution 4:
quick sort
optimize solution 3 by use one help function to do it

Time complexity : O(N) in the average case, O(N^2)in the worst case.
Space complexity : O(n).
'''
class Solution:
    def findKthLargest(self, nums: List[int], k: int) -> int:
        # sort nums by decreasing order, then pick k-1 element
        return self.quickSort(nums, k-1, 0, len(nums)-1)

    def quickSort(self, nums: List[int], k: int, start: int, end: int) -> int:
        if start == end:
            return nums[start]

        pivot = nums[end]
        i = start
        j = end-1
        while i < end and i <= j:
            if nums[i] < pivot:
                # swap i, j element, to keep i has larger element
                nums[i], nums[j] = nums[j], nums[i]
                j -= 1
            else:
                i += 1

        # swap i, pivot elemnt
        nums[i], nums[end] = nums[end], nums[i]

        if i == k:
            return nums[i]
        elif i < k:
            return self.quickSort(nums, k, i+1, end)
        else:
            return self.quickSort(nums, k, start, i-1)

