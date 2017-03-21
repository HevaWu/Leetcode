/*142. Linked List Cycle II Add to List
Description  Submission  Solutions
Total Accepted: 105186
Total Submissions: 339079
Difficulty: Medium
Contributors: Admin
Given a linked list, return the node where the cycle begins. If there is no cycle, return null.

Note: Do not modify the linked list.

Follow up:
Can you solve it without using extra space?

Hide Tags Linked List Two Pointers
Hide Similar Problems (E) Linked List Cycle (M) Find the Duplicate Number
 */






/*
two pointers (1 ms/ 16 test)
"oneMove" move one step at a time
"twoMove" move two steps at a time
suppose first meet at step "k", the length of the cycle is "r"
2k-k=nr, => k=nr
the distance between the start node of list and the start node of cycle is "s"
the distance between the start of list and the first meeting node is "k"
the distance between the start node of cycle and the first meeting node is "m"
s = k - m
s = nr-m = (n-1)r+(r+m)
takes n = 1, using one pointer start from the start node of the list,
"oneMove" pointer start from the meeting node
two pointers walk one step at a time,
the first time they meeting each other is the start of the cycle
 */

////////////////////////////////////////////////////////////////////////
//Java
/**
 * Definition for singly-linked list.
 * class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) {
 *         val = x;
 *         next = null;
 *     }
 * }
 */
public class Solution {
    public ListNode detectCycle(ListNode head) {
        if(head==null || head.next==null) return null;

        ListNode oneMove = head;
        ListNode twoMove = head;
        while(twoMove!=null && twoMove.next!=null){
            oneMove = oneMove.next;
            twoMove = twoMove.next.next;
            if(oneMove == twoMove){
                //two pointer meeting
                while(head != oneMove){
                    head = head.next;
                    oneMove = oneMove.next;
                }
                return oneMove;
            }
        }

        return null;
    }
}
