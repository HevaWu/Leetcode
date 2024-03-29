/*
Given a linked list, swap every two adjacent nodes and return its head.

You may not modify the values in the list's nodes. Only nodes itself may be
changed.



Example 1:


Input: head = [1,2,3,4]
Output: [2,1,4,3]
Example 2:

Input: head = []
Output: []
Example 3:

Input: head = [1]
Output: [1]


Constraints:

The number of nodes in the list is in the range [0, 100].
0 <= Node.val <= 100
*/

/*
Solution 2:
loop over node
*/
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode() : val(0), next(nullptr) {}
 *     ListNode(int x) : val(x), next(nullptr) {}
 *     ListNode(int x, ListNode *next) : val(x), next(next) {}
 * };
 */
class Solution {
 public:
  ListNode* swapPairs(ListNode* head) {
    if (head == nullptr || head->next == nullptr) {
      return head;
    }

    ListNode* dummy = new ListNode(0, head);
    ListNode* cur = dummy;
    while (cur->next != nullptr && cur->next->next != nullptr) {
      ListNode* next = cur->next->next;
      cur->next->next = next->next;
      next->next = cur->next;
      cur->next = next;
      cur = cur->next->next;
    }
    return dummy->next;
  }
};
