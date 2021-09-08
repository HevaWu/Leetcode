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
