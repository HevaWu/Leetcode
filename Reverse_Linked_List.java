/*
Given the head of a singly linked list, reverse the list, and return the reversed list.



Example 1:


Input: head = [1,2,3,4,5]
Output: [5,4,3,2,1]
Example 2:


Input: head = [1,2]
Output: [2,1]
Example 3:

Input: head = []
Output: []


Constraints:

The number of nodes in the list is the range [0, 5000].
-5000 <= Node.val <= 5000


Follow up: A linked list can be reversed either iteratively or recursively. Could you implement both?
*/

/*
Solution 2 faster than Solution 1
O(1) space

Solution 1:
recursively
ListNode nextNode = head.next;
ListNode preHead = reverseList(nextNode);
nextNode.next = head;
head.next = null;
return preHead;


Solution 2: 0 ms
iteratively
while loop , once head != null
update
    next = head.next
    head.next = pre
    pre = head
    head = next
return pre
 */


/*
Solution 1
recursive

Time Complexity: O(n)
Space Complexity: O(1)
*/
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) { val = x; }
 * }
 */
public class Solution {
    public ListNode reverseList(ListNode head) {
        if(head==null || head.next==null) return head;
        ListNode nextNode = head.next;
        ListNode preHead = reverseList(nextNode);
        nextNode.next = head;
        head.next = null;
        return preHead;
    }
}

public class Solution {
    public ListNode reverseList(ListNode head) {
        if(head==null || head.next==null) return head;
        ListNode cur = reverseList(head.next);
        //System.out.println(head.next.val + " " + head.val);
        head.next.next = head;
        head.next = null;
        return cur;
    }
}

/*
Solution 2
iterative

Time Complexity: O(n)
Space Complexity: O(1)
*/
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode() {}
 *     ListNode(int val) { this.val = val; }
 *     ListNode(int val, ListNode next) { this.val = val; this.next = next; }
 * }
 */
public class Solution {
    public ListNode reverseList(ListNode head) {
        if(head==null || head.next==null) return head;
        ListNode pre = null;
        while(head != null){
            ListNode next = head.next;
            head.next = pre;
            pre = head;
            head = next;
        }
        return pre;
    }
}