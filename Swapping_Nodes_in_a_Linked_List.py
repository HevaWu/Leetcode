'''
You are given the head of a linked list, and an integer k.

Return the head of the linked list after swapping the values of the kth node from the beginning and the kth node from the end (the list is 1-indexed).



Example 1:


Input: head = [1,2,3,4,5], k = 2
Output: [1,4,3,2,5]
Example 2:

Input: head = [7,9,6,6,7,8,3,0,9,5], k = 5
Output: [7,9,6,6,8,7,3,0,9,5]
Example 3:

Input: head = [1], k = 1
Output: [1]
Example 4:

Input: head = [1,2], k = 1
Output: [2,1]
Example 5:

Input: head = [1,2,3], k = 2
Output: [1,2,3]


Constraints:

The number of nodes in the list is n.
1 <= k <= n <= 105
0 <= Node.val <= 100
'''

'''
Solution 2:
optimize solution 1

only switch node.val would be enough, don't care link logic

Time Complexity: O(n)
Space Complexity: O(1)
'''
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def swapNodes(self, head: Optional[ListNode], k: int) -> Optional[ListNode]:
        # kth node
        first = head
        for i in range(k-1):
            first = first.next

        # n-k node
        second = head
        end = first
        while end.next:
            end = end.next
            second = second.next

        if first.val == second.val:
            return head

        # swap kth and n-kth node
        temp = first.val
        first.val = second.val
        second.val = temp

        return head
