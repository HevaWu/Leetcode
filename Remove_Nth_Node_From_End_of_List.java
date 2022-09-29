/*
Given a linked list, remove the n-th node from the end of list and return its head.

Example:

Given linked list: 1->2->3->4->5, and n = 2.

After removing the second node from the end, the linked list becomes 1->2->3->5.
Note:

Given n will always be valid.

Follow up:

Could you do this in one pass?
*/

/*
 * Solution 1:
 * one pass
 *
 * use cur pointer to help record position from header to nth node
 * keep this distance, use "node" as the previous node of the one should be deleted
 * once cur.next == nil, remove "node"'s next node, return head
 *
 * Time Complexity: O(n)
 * Space Complexity: O(1)
 */
/**
 * Definition for singly-linked list.
 * public class ListNode {
 * int val;
 * ListNode next;
 * ListNode() {}
 * ListNode(int val) { this.val = val; }
 * ListNode(int val, ListNode next) { this.val = val; this.next = next; }
 * }
 */
class Solution {
    public ListNode removeNthFromEnd(ListNode head, int n) {
        ListNode cur = head;
        while (n > 0) {
            cur = cur.next;
            n -= 1;
        }

        if (cur == null) {
            return head.next;
        }

        ListNode pre = head;
        while (cur.next != null) {
            cur = cur.next;
            pre = pre.next;
        }

        pre.next = pre.next.next;
        return head;
    }
}
