/*445. Add Two Numbers II Add to List
Description  Submission  Solutions
Total Accepted: 13471
Total Submissions: 29355
Difficulty: Medium
Contributors: Admin
You are given two non-empty linked lists representing two non-negative integers. The most significant digit comes first and each of their nodes contain a single digit. Add the two numbers and return it as a linked list.

You may assume the two numbers do not contain any leading zero, except the number 0 itself.

Follow up:
What if you cannot modify the input lists? In other words, reversing the lists is not allowed.

Example:

Input: (7 -> 2 -> 4 -> 3) + (5 -> 6 -> 4)
Output: 7 -> 8 -> 0 -> 7
Hide Company Tags Microsoft Bloomberg
Hide Tags Linked List
Hide Similar Problems (M) Add Two Numbers
*/






/*
Stack FILO
use two stack to help check the value in listnode
1. push two list into two stack seperately
2. each time pop the tail value in two stack, sum them, and add sum%10 to current list
    each time, update the head value, make it always at the head of this list
3. at the end, check if current head is 0,
    if it is, return head.next, else return head
 */

////////////////////////////////////////////////////////////////////////
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
    public ListNode addTwoNumbers(ListNode l1, ListNode l2) {
        Stack<Integer> s1 = new Stack<>();
        Stack<Integer> s2 = new Stack<>();

        while(l1 != null){
            s1.push(l1.val);
            l1 = l1.next;
        }

        while(l2 != null){
            s2.push(l2.val);
            l2 = l2.next;
        }

        int sum = 0;
        ListNode head = new ListNode(0);
        while(!s1.isEmpty() || !s2.isEmpty()){
            if(!s1.isEmpty()){
                sum += s1.pop();
            }
            if(!s2.isEmpty()){
                sum += s2.pop();
            }

            head.val = sum% 10;
            sum = sum / 10;
            ListNode cur = new ListNode(sum);
            cur.next = head;
            head = cur;
        }

        return head.val == 0 ? head.next : head;
    }
}
