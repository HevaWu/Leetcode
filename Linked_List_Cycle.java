/*141. Linked List Cycle Add to List
Description  Submission  Solutions
Total Accepted: 162858
Total Submissions: 457239
Difficulty: Easy
Contributors: Admin
Given a linked list, determine if it has a cycle in it.

Follow up:
Can you solve it without using extra space?

Hide Company Tags Amazon Microsoft Bloomberg Yahoo
Hide Tags Linked List Two Pointers
Hide Similar Problems (M) Linked List Cycle II
 */






/*
Solution 1 faster than Solution 2

Solution 1: two pointer, 1 ms/ 16 test
O(n) time O(1) space
"one" moves step by step
"two" moves two steps at a time
if there is a cycle in the list, two pointers will meet at some point

Solution 2: hash table 12 ms/ 16 test
check whether a node had been visited before
 */

////////////////////////////////////////////////////////////////////////
//Java
//Solution 1
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
    public boolean hasCycle(ListNode head) {
        if(head==null) return false;
        ListNode oneMove = head;
        ListNode twoMove = head;
        while(twoMove.next!=null && twoMove.next.next!=null){
            //only need to check twoMove.next and twoMove.next.next
            //since twoMove is always faster
            oneMove = oneMove.next;
            twoMove = twoMove.next.next;
            if(oneMove == twoMove) return true;
        }
        return false;
    }
}

public boolean hasCycle(ListNode head) {
    if (head == null || head.next == null) {
        return false;
    }
    ListNode slow = head;
    ListNode fast = head.next;
    while (slow != fast) {
        if (fast == null || fast.next == null) {
            return false;
        }
        slow = slow.next;
        fast = fast.next.next;
    }
    return true;
}




//Solution 2:
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
    public boolean hasCycle(ListNode head) {
        if(head == null) return false;

        Set<ListNode> setlist = new HashSet<>(); //use hashSet
        while(head != null){
            if(setlist.contains(head)) return true;
            setlist.add(head);
            head = head.next;
        }
        return false;
    }
}
