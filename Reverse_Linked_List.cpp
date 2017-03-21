/*206. Reverse Linked List Add to List
Description  Submission  Solutions
Total Accepted: 197320
Total Submissions: 447332
Difficulty: Easy
Contributors: Admin
Reverse a singly linked list.

click to show more hints.

Hint:
A linked list can be reversed either iteratively or recursively. Could you implement both?

Hide Company Tags Uber Facebook Twitter Zenefits Amazon Microsoft Snapchat Apple Yahoo Bloomberg Yelp Adobe
Hide Tags Linked List
Hide Similar Problems (M) Reverse Linked List II (M) Binary Tree Upside Down (E) Palindrome Linked List
 */




/////////////////////////////////////////////////////////////////////////////////////
//C++
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode(int x) : val(x), next(NULL) {}
 * };
 */
class Solution {
public:
    ListNode* reverseList(ListNode* head) {
        if(!head || !(head->next)) return head;
        ListNode *cur = reverseList(head->next);
        head->next->next = head;
        head->next = NULL;
        return cur;
    }
};





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

/////////////////////////////////////////////////////////////////////////////////////
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
