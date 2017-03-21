/*82. Remove Duplicates from Sorted List II   Add to List QuestionEditorial Solution  My Submissions
Total Accepted: 96525
Total Submissions: 336109
Difficulty: Medium
Contributors: Admin
Given a sorted linked list, delete all nodes that have duplicate numbers, leaving only distinct numbers from the original list.

For example,
Given 1->2->3->3->4->4->5, return 1->2->5.
Given 1->1->1->2->3, return 2->3.

Hide Tags Linked List
*/




/////////////////////////////////////////////////////////////////////////////////////
//C++




/*
set a preHead node as the pre node of head
then we can return the preHead.next at the end
init pre as preHead
init curr as head

use while loop to jump the duplicated node
then check if pre.next == cur
if it is, pre = curr.next
if not pre.next = curr.next
 */

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
    public ListNode deleteDuplicates(ListNode head) {
        if(head == null) return head;

        ListNode preHead=new ListNode(0); //use a ListNode as the pre node of head
        preHead.next=head;

        ListNode pre = preHead;  //init pre as preHead, is the pre node of curr node
        ListNode cur = head;

        while(cur != null){ //just check if cur is null
            while(cur.next != null && cur.val == cur.next.val){
                cur = cur.next;
            }
            if(pre.next == cur){
                pre = pre.next; //should jump the first node
            } else {
                pre.next = cur.next;
            }
            cur = cur.next; //remember go to the next element
        }
        return preHead.next;
    }
}

