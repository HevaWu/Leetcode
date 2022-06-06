/*
Write a program to find the node at which the intersection of two singly linked lists begins.

For example, the following two linked lists:


begin to intersect at node c1.



Example 1:


Input: intersectVal = 8, listA = [4,1,8,4,5], listB = [5,6,1,8,4,5], skipA = 2, skipB = 3
Output: Reference of the node with value = 8
Input Explanation: The intersected node's value is 8 (note that this must not be 0 if the two lists intersect). From the head of A, it reads as [4,1,8,4,5]. From the head of B, it reads as [5,6,1,8,4,5]. There are 2 nodes before the intersected node in A; There are 3 nodes before the intersected node in B.


Example 2:


Input: intersectVal = 2, listA = [1,9,1,2,4], listB = [3,2,4], skipA = 3, skipB = 1
Output: Reference of the node with value = 2
Input Explanation: The intersected node's value is 2 (note that this must not be 0 if the two lists intersect). From the head of A, it reads as [1,9,1,2,4]. From the head of B, it reads as [3,2,4]. There are 3 nodes before the intersected node in A; There are 1 node before the intersected node in B.


Example 3:


Input: intersectVal = 0, listA = [2,6,4], listB = [1,5], skipA = 3, skipB = 2
Output: null
Input Explanation: From the head of A, it reads as [2,6,4]. From the head of B, it reads as [1,5]. Since the two lists do not intersect, intersectVal must be 0, while skipA and skipB can be arbitrary values.
Explanation: The two lists do not intersect, so return null.


Notes:

If the two linked lists have no intersection at all, return null.
The linked lists must retain their original structure after the function returns.
You may assume there are no cycles anywhere in the entire linked structure.
Each value on each linked list is in the range [1, 10^9].
Your code should preferably run in O(n) time and use only O(1) memory.
*/

/*
Solution 1:
2 pointer

- pA(init A.head) pB(init B.head)
- if pA reach end, redirect it to B.head
  if pB reach end, redirect it to A.head
- when pA meets pB, we find intersection node
- if pA / pB reach end of list, 2 lists have no interactions

Time Complexity: O(m+n)
Space Complexity: O(1)
*/

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
