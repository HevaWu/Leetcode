'''
An integer array original is transformed into a doubled array changed by appending twice the value of every element in original, and then randomly shuffling the resulting array.

Given an array changed, return original if changed is a doubled array. If changed is not a doubled array, return an empty array. The elements in original may be returned in any order.



Example 1:

Input: changed = [1,3,4,2,6,8]
Output: [1,3,4]
Explanation: One possible original array could be [1,3,4]:
- Twice the value of 1 is 1 * 2 = 2.
- Twice the value of 3 is 3 * 2 = 6.
- Twice the value of 4 is 4 * 2 = 8.
Other original arrays could be [4,3,1] or [3,1,4].
Example 2:

Input: changed = [6,3,0,1]
Output: []
Explanation: changed is not a doubled array.
Example 3:

Input: changed = [1]
Output: []
Explanation: changed is not a doubled array.


Constraints:

1 <= changed.length <= 105
0 <= changed[i] <= 105
'''

'''
Solution 2:
optimize Solution 1

update element one by one use freq

- sort changed
- for each element in changed
  - check its freq exist
    - update freq[num]
    - check if its twice value exist
      - update freq[twice]
      - add value to original
    - not exist, return []

Time Complexity: O(nlogn)
- n is changed.count
Space Complexity: O(n)
'''
class Solution:
    def findOriginalArray(self, changed: List[int]) -> List[int]:
        freq = {}
        for num in changed:
            freq[num] = freq.get(num, 0) + 1

        changed.sort()
        original = []

        for num in changed:
            if freq[num] > 0:
                freq[num] = freq.get(num, 0) - 1
                twice = num * 2
                if freq.get(twice, 0) > 0:
                    freq[twice] = freq.get(twice, 0) - 1
                    original.append(num)
                else:
                    return []

        return original
