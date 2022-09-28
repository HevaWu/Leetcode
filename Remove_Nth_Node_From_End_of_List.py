'''
Given a linked list, remove the n-th node from the end of list and return its head.

Example:

Given linked list: 1->2->3->4->5, and n = 2.

After removing the second node from the end, the linked list becomes 1->2->3->5.
Note:

Given n will always be valid.

Follow up:

Could you do this in one pass?
'''

'''
 * Solution 1:
 * one pass
 *
 * use cur pointer to help record position from header to nth node
 * keep this distance, use "node" as the previous node of the one should be deleted
 * once cur.next == nil, remove "node"'s next node, return head
 *
 * Time Complexity: O(n)
 * Space Complexity: O(1)
 '''
# Definition for singly-linked list.
# class ListNode:
#     def __init__(self, val=0, next=None):
#         self.val = val
#         self.next = next
class Solution:
    def removeNthFromEnd(self, head: Optional[ListNode], n: int) -> Optional[ListNode]:
        cur = head
        while n > 0:
            cur = cur.next
            n -= 1

        if not cur: return head.next

        pre = head
        while cur.next:
            cur = cur.next
            pre = pre.next
        pre.next = pre.next.next
        return head
