/*160. Intersection of Two Linked Lists Add to List
Description  Submission  Solutions
Total Accepted: 116952
Total Submissions: 387872
Difficulty: Easy
Contributors: Admin
Write a program to find the node at which the intersection of two singly linked lists begins.


For example, the following two linked lists:

A:          a1 → a2
                   ↘
                     c1 → c2 → c3
                   ↗
B:     b1 → b2 → b3
begin to intersect at node c1.


Notes:

If the two linked lists have no intersection at all, return null.
The linked lists must retain their original structure after the function returns.
You may assume there are no cycles anywhere in the entire linked structure.
Your code should preferably run in O(n) time and use only O(1) memory.
Credits:
Special thanks to @stellari for adding this problem and creating all test cases.

Hide Company Tags Amazon Microsoft Bloomberg Airbnb
Hide Tags Linked List
*/





////////////////////////////////////////////////////////////////////////
//C++
class Solution {
public:
    ListNode *getIntersectionNode(ListNode *headA, ListNode *headB) {
        ListNode *pA = headA, *pB = headB;
        while(pA != pB){
            pA = pA ? pA->next : headB;
            pB = pB ? pB->next : headA;
        }
        return pA;
    }
};





/*
Solution 1: 3 ms/ 42 test
O(m+n) time O(1) space
keep check if there is an intersection between listA and listB
once one of the list is end, point it to another list

Solution 2: 3 ms/ 42 test
O(m+n) time O(1) space
count the length of two list
if lenA > lenB, move curA
if lenB > lenA, move curB
until two list have same length
then, find the intersection part
 */

////////////////////////////////////////////////////////////////////////
//Java
//Solution 1:
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) {
 *         val = x;
 *         next = null;
 *     }
 * }
 */
public class Solution {
    public ListNode getIntersectionNode(ListNode headA, ListNode headB) {
        if(headA==null || headB==null) return null;
        ListNode curA = headA;
        ListNode curB = headB;
        while(curA != curB){
            curA = curA!=null ? curA.next : headB;  //to the list B
            curB = curB!=null ? curB.next : headA;  //to the list A
        }
        return curA;
    }
}




//Solution 2
/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     int val;
 *     ListNode next;
 *     ListNode(int x) {
 *         val = x;
 *         next = null;
 *     }
 * }
 */
public class Solution {
    public ListNode getIntersectionNode(ListNode headA, ListNode headB) {
        if(headA == null || headB == null) return null;

        ListNode curA = headA;
        ListNode curB = headB;
        int lenA = getLength(curA);
        int lenB = getLength(curB);

        while(lenA > lenB){
            curA = curA.next;
            lenA--;
        }
        while(lenB > lenA){
            curB = curB.next;
            lenB--;
        }

        while(curA != curB){
            curA = curA.next;
            curB = curB.next;
        }

        return curA;
    }

    public int getLength(ListNode cur){
        int len = 0;
        while(cur != null){
            cur = cur.next;
            len++;
        }
        return len;
    }
}
