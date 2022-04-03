'''
31. Next Permutation  QuestionEditorial Solution  My Submissions
Total Accepted: 83164 Total Submissions: 299955 Difficulty: Medium
Implement next permutation, which rearranges numbers into the lexicographically next greater permutation of numbers.

If such arrangement is not possible, it must rearrange it as the lowest possible order (ie, sorted in ascending order).

The replacement must be in-place, do not allocate extra memory.

Here are some examples. Inputs are in the left-hand column and its corresponding outputs are in the right-hand column.
1,2,3 → 1,3,2
3,2,1 → 1,2,3
1,1,5 → 1,5,1
Hide Company Tags Google
Hide Tags Array
Hide Similar Problems (M) Permutations (M) Permutations II (M) Permutation Sequence (M) Palindrome Permutation II
'''

'''
Solution 2:
1. find first a[first] which is in the ascending order, if cannot find, just reverse this array would be the answer. Note: after finding this element, assign it to a variable for checking, otherwise it is hard to clarify the descending & target index at 0
2. betwen firstIndex+1 to n-1, find the element just larger than a[firstIndex], and swap them
3. now, a[firstIndex] is the fixed one, for firstIndex+1 to n-1, just reverse them would be the correct answer
//
Time complexity : O(n). In worst case, only two scans of the whole array are needed.
Space complexity : O(1). No extra space is used. In place replacements are done.
'''
class Solution:
    def nextPermutation(self, nums: List[int]) -> None:
        """
        Do not return anything, modify nums in-place instead.
        """

        # find first index which is ascending order
        index = len(nums)-2
        while index >= 0:
            if nums[index] < nums[index+1]:
                break
            index -= 1

        # check if array is already descending order
        # if all descending, directly reverse nums would be enough
        if index == -1:
            nums.reverse()
            return

        # find next index which is closest larger than nums[index]
        nextIndex = index+1
        for i in range(nextIndex, len(nums)):
            if nums[i] > nums[index] and i > nextIndex:
                nextIndex = i

        # swap nextIndex, index
        nums[index], nums[nextIndex] = nums[nextIndex], nums[index]

        # reverse index+1..., this will make remaining becomes to ascending order
        nums[index+1:len(nums)] = nums[index+1:len(nums)][::-1]