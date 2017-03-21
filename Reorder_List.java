/*143. Reorder List   Add to List QuestionEditorial Solution  My Submissions
Total Accepted: 81405
Total Submissions: 331412
Difficulty: Medium
Contributors: Admin
Given a singly linked list L: L0→L1→…→Ln-1→Ln,
reorder it to: L0→Ln→L1→Ln-1→L2→Ln-2→…

You must do this in-place without altering the nodes' values.

For example,
Given {1,2,3,4}, reorder it to {1,4,2,3}.

Hide Tags Linked List
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*reverse list
1. find the middle element
2. reverse the element behind the mid(change 1-2-3-4-5-6 to 1-2-3-6-5-4)
3. insert the behind-mid element to the before-mid element(change 1-2-3-6-5-4 to 1-6-2-5-3-4)*/

/////////////////////////////////////////////////////////////////////////////////////
//Java
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) { val = x; }
 * }
 */
public class Solution {
    public void reorderList(ListNode head) {
        if(head == null || head.next == null) return;

        //Find the middle element
        ListNode p1 = head;
        ListNode p2 = head;
        while(p2.next != null && p2.next.next != null){
            p1 = p1.next;
            p2 = p2.next.next;
        }

        //change 1-2-3-4-5-6 to 1-2-3-6-5-4
        ListNode preMid = p1;
        ListNode preCur = p1.next;
        while(preCur.next != null){ //did not reverse all of the remain element(the element behind the mid element)
            ListNode cur = preCur.next;
            preCur.next = cur.next;
            cur.next = preMid.next; //pay attention
            preMid.next = cur;
        }

        //change 1-2-3-6-5-4 to 1-6-2-5-3-4
        p1 = head;
        p2 = preMid.next;
        while(p1 != preMid){
            preMid.next = p2.next;
            p2.next = p1.next;
            p1.next = p2;

            p1 = p2.next;
            p2 = preMid.next;
        }
    }
}

