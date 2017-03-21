/*92. Reverse Linked List II Add to List
Description  Submission  Solutions
Total Accepted: 98507
Total Submissions: 328950
Difficulty: Medium
Contributors: Admin
Reverse a linked list from position m to n. Do it in-place and in one-pass.

For example:
Given 1->2->3->4->5->NULL, m = 2 and n = 4,

return 1->4->3->2->5->NULL.

Note:
Given m, n satisfy the following condition:
1 ≤ m ≤ n ≤ length of list.

Hide Tags Linked List
Hide Similar Problems (E) Reverse Linked List
*/






/*
Solution 2 faster than Solution 1

Solution 1: 1 ms/ 44 test
set the pre pointer as a marker for the node before reversing
then, each time change the pre.next
set "start" pointer to the beginning of the sub-list that will be reversed
set "second" pointer to the node that will be reversed
// 1 - 2 -3 - 4 - 5 ; m=2; n =4 ---> pre = 1, start = 2, second = 3
// first reversing : temp->1 - 3 - 2 - 4 - 5; pre = 1, start = 2, second = 4
// second reversing: temp->1 - 4 - 3 - 2 - 5; pre = 1, start = 2, second = 5 (finish)
temp is always the head of the list

Solution 2. 0 ms/ 44 test
still have a pre pointer as a marker for the node before reversing
donot use temp as the head of the return list
just at the end, judge if m==1, if it is, head = pre.next
return head
*/

////////////////////////////////////////////////////////////////////////
//Java
//Solution 1
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) { val = x; }
 * }
 */
public class Solution {
    public ListNode reverseBetween(ListNode head, int m, int n) {
        if(head == null) return null;
        ListNode temp = new ListNode(0);
        temp.next = head; //temp is the head of current list

        ListNode pre = temp;  //pre is the pointer of the node before reversing
        for(int i = 0; i < m-1; ++i){ // m-1, find the correct node
            pre = pre.next;
        }

        ListNode start = pre.next;
        ListNode second = start.next;
        for(int i = 0; i < n-m; ++i){
            start.next = second.next;
            second.next = pre.next;
            pre.next = second;
            second = start.next; //second is always the next node after start
        }

        return temp.next;
    }
}




//Solution 2
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) { val = x; }
 * }
 */
public class Solution {
    public ListNode reverseBetween(ListNode head, int m, int n) {
        if(head==null) return head;
        ListNode pre = new ListNode(0);
        pre.next = head;
        for(int i = 0; i < m-1; ++i){// here is m-1
            pre = pre.next;
        }

        /*ListNode start = pre.next;
        for(int i = 0; i < n-m; ++i){
            ListNode nextNode = start.next;
            start.next = nextNode.next;
            nextNode.next = pre.next;
            pre.next = nextNode;
        }*/

        ListNode start = pre.next;
        ListNode second = start.next;
        for(int i = 0; i < n-m; ++i){ //here is n-m
            start.next = second.next;
            second.next = pre.next;
            pre.next = second;
            second = start.next; //second is always the next node after start
        }

        if(m==1) head = pre.next;

        return head;
    }
}
